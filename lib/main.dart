import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Map data;
  late List userData;
  Future getData() async {
    http.Response response =await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    data = json.decode(response.body);
    setState((){
      userData = data["data"];
    });
    debugPrint(userData.toString());
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index){
          return SizedBox(
              width: double.infinity,
              height: 130,
              child:Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    )
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(userData[index]["avatar"]),
                              radius: 40,
                            ),
                          ),
                          SizedBox(width: 33),
                          Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: 20, top: 10),
                                  child: Text("${userData[index]["id"]}")
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text("${userData[index]["email"]}")
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text("${userData[index]["first_name"]}"),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text("${userData[index]["last_name"]}"),
                              )
                            ],
                          ),
                        ]
                    )
                )
                ),
              )
          );
        },
      ),
    );
  }
}

