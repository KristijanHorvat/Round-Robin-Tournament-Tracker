import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewCompetition extends StatefulWidget {
  NewCompetition({Key? key, required this.user}) : super(key: key);
  final String user;
  @override
  State<NewCompetition> createState() => _NewCompetition();
}

class _NewCompetition extends State<NewCompetition> {
  
  late Auth0Web auth0;
  late TextEditingController _controller_competition;
  late TextEditingController _controller_competitors;
late List<String> competitors_list= <String>[];
FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = FirebaseFirestore.instance.collection('competion');

    Future<void> addCompetition(String user, String name, String competitors) {
      // Call the user's CollectionReference to add a new user
      competitors_list = competitors.split(";");

      return users.doc(user)
          .set({
            'user': user,
            'name': name, // John Doe
            'competitors': competitors_list, // Stokes and Sons
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    Future<String?> getData(String user) async {
    final docRef = firestore.collection("competion").doc(user);

    await docRef.get().then(
          (DocumentSnapshot doc) async {
  if(doc.exists){

        

  }else {


  return Future.error("Error");
}
      },
      onError: (e) => print("Error getting document: $e"),
    );

return "null";
  }

  @override
  void initState() {
    super.initState();
    auth0 = Auth0Web('dev-qsx8p0kak4i4te6x.eu.auth0.com', 'u8Sm5SpErksMHApgWYrOLNoVacxvGyjv');
    _controller_competition = TextEditingController();
    _controller_competitors = TextEditingController();

  
  }

  @override
  Widget build(BuildContext context) {
       double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
  return Scaffold(
    appBar: AppBar(leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.of(context).pop(),
  ), 
  title: Text("Novo natjecanje"),
  centerTitle: true,),
    body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
           if (widget.user != null) Text("Korisnik: "+widget.user, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,decoration: TextDecoration.none, fontSize: 15),),
           Text("Naziv natjecanja:"),
           Container(
            width: width/5,
            height: height/10,
            child: TextField(
              decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          width: 3, color: Colors.blue), //<-- SEE HERE
    ),
  ),
              controller: _controller_competition,)),
           Text("Naziv natjecatelja (unesi s ; npr: Kiki;Pero;Ivan... min 4. maks 8):"),
           Container(
            width: width/5,
            height: height/10,
            child: TextField(
              decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          width: 3, color: Colors.blue), //<-- SEE HERE
    ),
  ),
              controller: _controller_competitors,)),
           ElevatedButton(onPressed: (){
            addCompetition(widget.user, _controller_competition.text, _controller_competitors.text);
           }, child: Text("Spremi"))
          ],
        ),
    ),
  );
  }
}