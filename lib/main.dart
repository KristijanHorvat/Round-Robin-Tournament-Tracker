import 'dart:html';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sample/constants.dart';
import 'package:sample/newComp.dart';
import 'package:sample/points_page.dart';
import 'package:sample/profile_view.dart';
import 'package:sample/public_results_page.dart';
import 'example_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'accessories.dart';

void main() async {

   await dotenv.load();
await Firebase.initializeApp(
  options: FirebaseOptions(
      apiKey: "AIzaSyBZj5sMxao2ZB4MVUDB-P3lWdIRFSyGo20",
      appId: "1:525087708940:web:1a20ed1da80475edfa1b29",
      messagingSenderId: "525087708940",
      projectId: "dz1app",
    ),
);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const ExampleApp(),
      '/comp2': (context) => NewCompetition(user: _user!.name!),
      '/publiccomp': (context) => Result_Page(user: _user!.name!),
      '/pointspage': (context) => Points_page(user: _user!.name!),
  },
  ));
}
  UserProfile? _user;

  late Auth0 auth0;
  late Auth0Web auth0Web;
class ExampleApp extends StatefulWidget {
  final Auth0? auth0;
  const ExampleApp({this.auth0, final Key? key}) : super(key: key);

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
    getData(getUserFromUrl(window.location.href));
    getDataPoints(getUserFromUrl(window.location.href));
   // auth0Web = Auth0Web("dev-qsx8p0kak4i4te6x.eu.auth0.com", "u8Sm5SpErksMHApgWYrOLNoVacxvGyjv");
  
  
  });
    auth0 = widget.auth0 ??
        Auth0("dev-qsx8p0kak4i4te6x.eu.auth0.com", "u8Sm5SpErksMHApgWYrOLNoVacxvGyjv");
    auth0Web =
        Auth0Web("dev-qsx8p0kak4i4te6x.eu.auth0.com", "u8Sm5SpErksMHApgWYrOLNoVacxvGyjv");

    if (kIsWeb) {
      auth0Web.onLoad().then((final credentials) => setState(() {
            _user = credentials?.user;
          }));
    }
  }

  Future<void> login() async {
    try {
      if (kIsWeb) {
        return auth0Web.loginWithRedirect(redirectUrl: 'https://dz1app.web.app/'); //http://localhost:3000
      }

    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      if (kIsWeb) {
        await auth0Web.logout(returnToUrl: 'https://dz1app.web.app/');//https://dz1app.web.app/
      } else {
       
        setState(() {
          _user = null;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  String getUserFromUrl(String url){
    var uri = Uri.parse(url);
    print(uri.queryParameters.values.last);
  return uri.queryParameters.values.last;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('points');
  late final List<String> competitors_table = <String>[];
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

Future<String?> getDataPoints(String? user) async {
    final docRef = firestore.collection("points").doc(user);

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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var table = generateCompetition(competitors_table);
     bubleSort();
    setState(() {
      
    });
    return MaterialApp(
      home: Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(
          top: padding,
          bottom: padding,
          left: padding / 2,
          right: padding / 2,
        ),
        child: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center, children: [
           /* Expanded(
                child: Row(children: [
              _user != null
                  ? Expanded(child: UserWidget(user: _user))
                  : const Expanded(child: HeroWidget())
            ])),*/
            _user != null
                ? Column(
                  children: [
                    ProfileView(user: _user!),
                    ElevatedButton(
                        onPressed: logout,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        child: const Text('Odjava'),
                      ),
                  ],
                )
                : Column(
                  
                  children: [
                    
                    
                    ElevatedButton(
                        onPressed: login,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        child: const Text('Prijava'),
                      ),
                     // Text(getUserFromUrl(window.location.href)),
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
                  ],
                )
          ]),
        ),
      )),
    );
  }
}

