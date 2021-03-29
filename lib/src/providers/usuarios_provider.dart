import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuariosProvider{

  final String _firebaseToken = 'AIzaSyA1B89r6HsLNstkaxi0Xu6SsNFkzHHDmgs';

  Future nuevoUsuario ( String email, String password ) async {

    final authData = {
      'email'     : email,
      'password'  : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(

      Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken'),
      body: json.encode( authData )

    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    print( decodedResp );
  }

}