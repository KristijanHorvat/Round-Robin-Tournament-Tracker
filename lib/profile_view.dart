import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'newComp.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({Key? key, required this.user}) : super(key: key);

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (user.name != null) Text("Korisnik: "+user.name!, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,decoration: TextDecoration.none, fontSize: 15),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width/5,
            height: height/10,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewCompetition(user: user.name!)));           
              }, 
              child: Text("Novo natjecanje")),
          ),
        ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: width/5,
              height: height/10,
              child: ElevatedButton(
              onPressed: (){
            
              }, 
              child: Text("Azuiraj bodove")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: width/5,
              height: height/10,
              child: ElevatedButton(
              onPressed: (){
            
              }, 
              child: Text("Natjecanje")),
            ),
          ),
          
      ],
    );
  }
}