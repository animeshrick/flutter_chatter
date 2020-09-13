import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HttpReqApi extends StatefulWidget {
  @override
  _HttpReqApiState createState() => _HttpReqApiState();
}

class _HttpReqApiState extends State<HttpReqApi> {
  ///json place holder + basics
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      data = json.decode(response.body);
    });
    //print(data[1]["title"]);
    //print(response.body);
    return "Success!";
  }

  final String url = 'https://swapi.dev/api/people';
  List jsonData;

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      var convertDatatoJson = json.decode(response.body);
      jsonData = convertDatatoJson["results"];
    });
    //print(data[1]["title"]);
    //print(response.body);
    return "Success Json !";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
    getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http Request'),
      ),
      body: ListView.builder(
        itemCount: jsonData == null ? 0 : jsonData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name :" + jsonData[index]["name"]),
                Text("Mass :" + jsonData[index]["mass"]),
                Text("Height :" + jsonData[index]["height"]),
                Text("Hair Color :" + jsonData[index]["hair_color"]),
              ],
            ),
          );
        },
      ),

      ///json place holder
//      body: ListView.builder(
//        itemCount: data == null ? 0 : data.length,
//        itemBuilder: (BuildContext context, int index) {
//          return Card(
//            child: Text(data[index]["title"]),
//          );
//        },
//      ),

      ///basic
//      body: Center(
//        child: RaisedButton(
//          onPressed: getData,
//          child: Text(
//            'get data',
//            style: TextStyle(color: Colors.blue),
//          ),
//        ),
//      ),
    );
  }
}
