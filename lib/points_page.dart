import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Points_page extends StatefulWidget {
  Points_page({Key? key, required this.user}) : super(key: key);
  final String user;
  @override
  State<Points_page> createState() => _Points_page();
}

class _Points_page extends State<Points_page> {
  
  late Auth0Web auth0;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('points');
    late final List<String> competitors_table = <String>[];
    bool flag=false;
 
  List<String> dropdownvalue = [];
  List<double> points = [];
  List<String> winLoseValue =[];
  var table;

    void generatePoints(){
      points.clear();
      for(int i=0;i<competitors_table.length;i++) points.add(0);
      for(int i=0;i<competitors_table.length;i++){
        for(int j=0;j<table.length;j++){
        if(competitors_table[i]==table[j]){
          if(dropdownvalue[j]=="Nista") points[i]+=0;
          if(dropdownvalue[j]=="Pobjeda") points[i]+=double.parse(winLoseValue[0]);
          if(dropdownvalue[j]=="Remi") points[i]+=double.parse(winLoseValue[1]);
          if(dropdownvalue[j]=="Poraz") points[i]+=double.parse(winLoseValue[2]);
        }
        }
      }
      print(points.toString());
    }

    Future<void> addCompetition2() {
      generatePoints();
      return users.doc(widget.user)
          .set({
            'user': widget.user,
            'winLose':dropdownvalue,
            'points':points,
          })
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Dodano'),)))
          .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Neuspjesno dodavanje'),)));
    }

    Future<String?> getData(String user) async {
    final docRef = firestore.collection("competion").doc(user);

    await docRef.get().then(
          (DocumentSnapshot doc) async {
  if(doc.exists){
    final data = doc.data() as Map<String, dynamic>;

    for(int i=0;i<data["competitors"].length; i++){
      competitors_table.add(data["competitors"][i]);
    }
     print(competitors_table.toString()); 
    for(int i=0;i<data["pointsWinLoseRemi"].length; i++){
      winLoseValue.add(data["pointsWinLoseRemi"][i]);
    }
     print(winLoseValue.toString()); 
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

   // if(flag==false && dropdownvalue.isEmpty) for(int i=0;i<competition.length;i++){
    //  dropdownvalue.add("Nista");
     // if(flag==false) flag=true;
   // }
    setState(() {
      
    });
    return competition;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
    getData(widget.user);
    getDataPoints();
  });
    
    
    auth0 = Auth0Web('dev-qsx8p0kak4i4te6x.eu.auth0.com', 'u8Sm5SpErksMHApgWYrOLNoVacxvGyjv');
  }

  @override
  Widget build(BuildContext context) {
       double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    table = generateCompetition(competitors_table);
    int j= 0;
    var items = [     
    "Pobjeda",
    "Remi",
    "Poraz",
    "Nista"
  ]; 
  
  return Scaffold(
    appBar: AppBar(leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.of(context).pop(),
  ), 
  title: Text("Ažuriraj bodove"),
  centerTitle: true,),
    body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           SizedBox(
            width: width/2,
            height: height/2,
             child: SingleChildScrollView(
               child: Table(
               border: TableBorder.all(width: 1.0, color: Colors.black),
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
                   TableCell(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton( 
                value: dropdownvalue[i], 
                icon: const Icon(Icons.keyboard_arrow_down),     
                  
                // Array list of items 
                items: items.map((String items) { 
                  return DropdownMenuItem( 
                    value: items, 
                    child: Text(items), 
                  ); 
                }).toList(), 
                onChanged: (String? newValue) {  
                  setState(() { 
                    dropdownvalue[i] = newValue!; 
                    print(dropdownvalue.toString());
                  }); 
                }, 
                         ),
                    ],
                   ))
                 ])
               ]
                        ),
             ),
           ),
           ElevatedButton(onPressed: (){
            addCompetition2();
            
           }, child: Text("Ažuriraj"))
          ],
        ),
    ),
  );
  }
}