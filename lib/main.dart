import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_deber/services/google_signin_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Login con Gmail',
            style: TextStyle(fontSize: 40),
          ),
          actions: [
            IconButton(
              icon: Icon(FontAwesomeIcons.doorOpen),
              onPressed: () {
                //todo SingOut
                GoogleSignInService.singOut();
                print("Cerrando sesión");
              },
            ),
          ],
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  splashColor: Colors.transparent,
                  minWidth: double.infinity,
                  height: 48,
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.google, color: Colors.white),
                      Spacer(),
                      Text(
                        "Sign In with Googles",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 35),
                      ),
                    ],
                  ),
                  onPressed: () {
                    //recordar que esto es un future y podría esperarlo
                    //con por ejemplo el await para esperar el resultado
                    //que sería la información del usuario de google
                    GoogleSignInService.signInWithGoogle();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
