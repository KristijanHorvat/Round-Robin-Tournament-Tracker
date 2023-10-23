import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:sample/constants.dart';
class Result_Page extends StatefulWidget {
  Result_Page({Key? key, required this.user}) : super(key: key);
  final String? user;
  @override
  State<Result_Page> createState() => _Result_Page();
}

class _Result_Page extends State<Result_Page> {
  

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('points');
    late final List<String> competitors_table = <String>[];
    bool flag=false;

  List<String> dropdownvalue = [];
  List<double> points = [];


    Future<String?> getData(String? user) async {
    final docRef = firestore.collection("competion").doc(user);

    await docRef.get().then(
          (DocumentSnapshot doc) async {
  if(doc.exists){
    final data = doc.data() as Map<String, dynamic>;

    for(int i=0;i<data["competitors"].length; i++){
      competitors_table.add(data["competitors"][i]);
    }
     print(competitors_table.toString()); 

     setState(() {
       
     });
  }else {


  return Future.error("Error");
}
      },
      onError: (e) => print("Error getting document: $e"),
    );

return "null";
  }

Future<String?> getDataPoints() async {
    final docRef = firestore.collection("points").doc(widget.user);

    await docRef.get().then(
          (DocumentSnapshot doc) async {
  if(doc.exists){
    final data = doc.data() as Map<String, dynamic>;

    for(int i=0;i<data["winLose"].length; i++){
      dropdownvalue.add(data["winLose"][i]);
    }
     print(dropdownvalue.toString());
     print(data["points"].length); 
for(int i=0;i<data["points"].length; i++){
      points.add(data["points"][i]);
    }
     print(points.toString()); 
     setState(() {
       
     });
  }else {


  return Future.error("Error");
}
      },
      onError: (e) => print("Error getting document: $e"),
    );

return "null";
  }

  List<String> generateCompetition(List<String> competitors){
    List<String> competition = [];
    if(competitors.length == 4 || competitors.length == 3){
      if(competitors.length == 3) competition.add("");
      competition.add(competitors[0]);
      competition.add(competitors[3]);
      competition.add(competitors[1]);
      competition.add(competitors[2]);
      
      competition.add(competitors[3]);
      competition.add(competitors[2]);
      competition.add(competitors[0]);
      competition.add(competitors[1]);

      competition.add(competitors[1]);
      competition.add(competitors[3]);
      competition.add(competitors[2]);
      competition.add(competitors[0]);
    }

if(competitors.length == 6 || competitors.length == 5){
      if(competitors.length == 5) competition.add("");
      competition.add(competitors[0]);
      competition.add(competitors[5]);
      competition.add(competitors[1]);
      competition.add(competitors[4]);
      competition.add(competitors[2]);
      competition.add(competitors[3]);
      
      competition.add(competitors[5]);
      competition.add(competitors[3]);
      competition.add(competitors[4]);
      competition.add(competitors[2]);
      competition.add(competitors[0]);
      competition.add(competitors[1]);

      competition.add(competitors[1]);
      competition.add(competitors[5]);
      competition.add(competitors[2]);
      competition.add(competitors[0]);
      competition.add(competitors[3]);
      competition.add(competitors[4]);

      competition.add(competitors[5]);
      competition.add(competitors[4]);
      competition.add(competitors[0]);
      competition.add(competitors[3]);
      competition.add(competitors[1]);
      competition.add(competitors[2]);

      competition.add(competitors[2]);
      competition.add(competitors[5]);
      competition.add(competitors[3]);
      competition.add(competitors[1]);
      competition.add(competitors[4]);
      competition.add(competitors[0]);
    }

    if(competitors.length == 8 || competitors.length == 7){
      if(competitors.length == 7) competition.add("");
      competition.add(competitors[0]);
      competition.add(competitors[7]);
      competition.add(competitors[1]);
      competition.add(competitors[6]);
      competition.add(competitors[2]);
      competition.add(competitors[5]);
      competition.add(competitors[3]);
      competition.add(competitors[4]);
      //kolo2
      competition.add(competitors[7]);
      competition.add(competitors[4]);
      competition.add(competitors[5]);
      competition.add(competitors[3]);
      competition.add(competitors[6]);
      competition.add(competitors[2]);
      competition.add(competitors[0]);
      competition.add(competitors[1]);
//kolo3
      competition.add(competitors[1]);
      competition.add(competitors[7]);
      competition.add(competitors[2]);
      competition.add(competitors[0]);
      competition.add(competitors[3]);
      competition.add(competitors[6]);
      competition.add(competitors[4]);
      competition.add(competitors[5]);
//kolo4
      competition.add(competitors[7]);
      competition.add(competitors[5]);
      competition.add(competitors[6]);
      competition.add(competitors[4]);
      competition.add(competitors[0]);
      competition.add(competitors[3]);
      competition.add(competitors[1]);
      competition.add(competitors[2]);
//kolo5
      competition.add(competitors[2]);
      competition.add(competitors[7]);
      competition.add(competitors[3]);
      competition.add(competitors[1]);
      competition.add(competitors[4]);
      competition.add(competitors[0]);
      competition.add(competitors[5]);
      competition.add(competitors[6]);

      //kolo6
      competition.add(competitors[7]);
      competition.add(competitors[6]);
      competition.add(competitors[0]);
      competition.add(competitors[5]);
      competition.add(competitors[1]);
      competition.add(competitors[4]);
      competition.add(competitors[2]);
      competition.add(competitors[3]);
      //kolo7
      competition.add(competitors[3]);
      competition.add(competitors[7]);
      competition.add(competitors[4]);
      competition.add(competitors[2]);
      competition.add(competitors[5]);
      competition.add(competitors[1]);
      competition.add(competitors[6]);
      competition.add(competitors[0]);
    }

  //  if(flag==false && dropdownvalue.isEmpty) for(int i=0;i<competition.length;i++){
    //  dropdownvalue.add("Nista");
  //    if(flag==false) flag=true;
   // }
    setState(() {
      
    });
    return competition;
  }

List<String> sortPlayers=[];
List<double> sortPlayersPoints=[];

void bubleSort(){

  for(int i=0;i<points.length;i++){
    sortPlayers.add(competitors_table[i]);
    sortPlayersPoints.add(points[i]);
  }

  int lengthOfArray = sortPlayersPoints.length;
  for (int i = 0; i < lengthOfArray - 1; i++) {
    for (int j = 0; j < lengthOfArray - i - 1; j++) {
      if (sortPlayersPoints[j] < sortPlayersPoints[j + 1]) {
        double temp = sortPlayersPoints[j];
        String temp2 = sortPlayers[j];

        sortPlayersPoints[j] = sortPlayersPoints[j + 1];
        sortPlayers[j] = sortPlayers[j + 1];

        sortPlayersPoints[j + 1] = temp;
        sortPlayers[j + 1] = temp2;

      }
    }
  }
}

Future<bool> checkAuth() async {
 // print(await auth0Web.hasValidCredentials());
 //await auth0Web.hasValidCredentials();
  return true;
}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
    getData(widget.user);
    getDataPoints();
   // auth0Web = Auth0Web("dev-qsx8p0kak4i4te6x.eu.auth0.com", "u8Sm5SpErksMHApgWYrOLNoVacxvGyjv");
  
  
  });
  }
//late Auth0Web auth0Web;
  @override
  Widget build(BuildContext context) {
       double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var table = generateCompetition(competitors_table);
    int j= 0;
    var items = [     
    "Pobjeda",
    "Remi",
    "Poraz",
    "Nista"
  ]; 
  bubleSort();
  
  return Scaffold(
    appBar: checkAuth()==false ? AppBar(title: Text("Ljestvica"),
      centerTitle: true,) : AppBar(leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.of(context).pop()), 
      title: Text("Ljestvica"),
      centerTitle: true,
    ),
    body: Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                  width: width/3,
                  height: height/2,
                   child: SingleChildScrollView(
                     child: Table(
                     border: TableBorder.all(width: 2.0, color: Colors.blue.shade900),
                     children: [
                               
                       for (int i = 0; i<table.length;i++) TableRow(
                         children: [
                          TableCell(child: Container(
                           color: i%(table.length/competitors_table.length+1)==0 ? Colors.green : Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Kolo "+(((i+1)/competitors_table.length).ceil()).toString())
                              ],
                            ),
                          ),),
                         TableCell(
                           child: Container(
                            color: i%2==0 ? Colors.blue : Colors.white,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: <Widget>[
                                Text(table[i]),
                               ],
                             ),
                           ),
                         ),
                         TableCell(
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(dropdownvalue[i])
                          ],
                         ))
                       ])
                     ]
                              ),
                   ),
                 ),
               ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                  width: width/3,
                  height: height/2,
                   child: SingleChildScrollView(
                     child: Table(
                     border: TableBorder.all(width: 2.0, color: Colors.blue.shade900),
                     children: [
                               
                       for (int i = 0; i<competitors_table.length;i++) TableRow(
                         children: [
                          TableCell(
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: <Widget>[
                              Text((i+1).toString()+"."),
                             ],
                           ),
                         ),
                         TableCell(
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: <Widget>[
                              Text(sortPlayers[i]),
                             ],
                           ),
                         ),
                         TableCell(child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(sortPlayersPoints[i].toString())
                          ],
                         ))
                       ])
                     ]
                              ),
                   ),
                 ),
          ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: Uri.base.toString()+"&name=${widget.user}"));
              }, 
              child: Text("Kopiraj link za prijatelja u clipboard!")),
        ],
      ),
      
    ),
  );
  }
}