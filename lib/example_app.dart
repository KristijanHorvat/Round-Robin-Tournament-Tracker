import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'profile_view.dart';
import 'constants.dart';
import 'hero.dart';
import 'user.dart';

class ExampleApp extends StatefulWidget {
  final Auth0? auth0;
  const ExampleApp({this.auth0, final Key? key}) : super(key: key);

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  UserProfile? _user;

  late Auth0 auth0;
  late Auth0Web auth0Web;

  @override
  void initState() {
    super.initState();
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
        return auth0Web.loginWithRedirect(redirectUrl: 'http://localhost:3000');
      }

    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      if (kIsWeb) {
        await auth0Web.logout(returnToUrl: 'http://localhost:3000');
      } else {
       
        setState(() {
          _user = null;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(final BuildContext context) {
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
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                        child: const Text('Logout'),
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
                        child: const Text('Login'),
                      ),
                  ],
                )
          ]),
        ),
      )),
    );
  }
}
