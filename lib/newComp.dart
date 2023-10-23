import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  late TextEditingController _controller_win;
  late TextEditingController _controller_remi;
  late TextEditingController _controller_lost;

late List<String> competitors_list= <String>[];
late List<String> pointsWinLoseRemi= <String>[];
late List<String> winLoseFields= <String>[];

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = FirebaseFirestore.instance.collection('competion');
CollectionReference pointsFirebase = FirebaseFirestore.instance.collection('points');

    Future<void> addCompetition(String user, String name, String competitors, String winPoints, String remiPoints, String lostPoints) {
      // Call the user's CollectionReference to add a new user
      competitors_list = competitors.split(";");
      pointsWinLoseRemi.add(winPoints);
      pointsWinLoseRemi.add(remiPoints);
      pointsWinLoseRemi.add(lostPoints);
      
      return users.doc(user)
          .set({
            'user': user,
            'name': name, // John Doe
            'competitors': competitors_list,
            'pointsWinLoseRemi': pointsWinLoseRemi
             // Stokes and Sons
          })
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Dodano'),)))
          .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Neuspjesno dodavanje'),)));
    }
Future<void> addCompetition2() {
      for(int i=0;i<(competitors_list.length*(competitors_list.length-1));i++){
        winLoseFields.add("Nista");
      }
      return pointsFirebase.doc(widget.user)
          .set({
            'user': widget.user,
            'winLose': winLoseFields,
             // Stokes and Sons
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
      _controller_competition.text=data["name"];

      _controller_competitors.text=data["competitors"].join(";");
      _controller_win.text=data["pointsWinLoseRemi"][0];
      _controller_remi.text=data["pointsWinLoseRemi"][1];
      _controller_lost.text=data["pointsWinLoseRemi"][2];
      
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
    _controller_win = TextEditingController();
    _controller_remi = TextEditingController();
  _controller_lost = TextEditingController();
  getData(widget.user);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                      Text("Pobjeda donosi: "),
                      SizedBox(
                        width: width/15,
                        height: height/10,
                        child: TextField(
                                    decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Colors.blue), //<-- SEE HERE
                          ),
                        ),
                                    controller: _controller_win,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
              ], ),
                      ),
                      Text("boda"),
                  ]
                ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                      Text("Remi donosi: "),
                      SizedBox(
                        width: width/15,
                        height: height/10,
                        child: TextField(
                                    decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Colors.blue), //<-- SEE HERE
                          ),
                        ),
                                    controller: _controller_remi,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
              ], ),
                      ),
                      Text("boda"),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                      Text("Poraz donosi: "),
                      SizedBox(
                        width: width/15,
                        height: height/10,
                        child: TextField(
                                    decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Colors.blue), //<-- SEE HERE
                          ),
                        ),
                                    controller: _controller_lost,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
              ], ),
                      ),
                      Text("boda"),
                  ]
                ),
              
           ElevatedButton(onPressed: (){
            addCompetition(widget.user, _controller_competition.text, _controller_competitors.text, _controller_win.text, _controller_remi.text, _controller_lost.text);
            addCompetition2();
           }, child: const Text("Spremi"))
          ],
        ),
    ),
  );
  }
}