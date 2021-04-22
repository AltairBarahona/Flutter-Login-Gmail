import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInService {
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      //no usaré esa info entonces sería raro que la pida
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

//static para poder accederlo sin instanciar,
//la estructura es similar a la documentación del
//paquete sign_ing_google para flutter
  static Future signInWithGoogle() async {
    try {
      //comienza autenticación de google
      final account = await _googleSignIn.signIn();

      //esto es un future que tiene varios tokens
      final googleKey = await account.authentication;

      print("==========ID TOKEN==========");
      print(account);
      //token generado por google para autenticar contra backend
      print(googleKey.idToken);

      //
      final signInWithGoogleEndpoint = Uri(
          scheme: "https",
          host: "google-signin-deber.herokuapp.com",
          path: "/google");

      final session = await http.post(signInWithGoogleEndpoint, body: {
        "token": googleKey.idToken,
      });

      print("========= backend =========");
      print(session.body);

      //TODO: llamar un servicio REST a nuestro backend con el
      //id token

      //si llega significa que se autenticó un usuario
      return account;
    } catch (e) {
      print("Error en Google SignIn");
      print(e);
      return null;
    }
  }

  static Future singOut() async {
    await _googleSignIn.signOut();
  }
}
