import 'dart:async';

class LoginBloc {

  final _emailController = new StreamController<String>.broadcast();
  final _passwordController = new StreamController<String>.broadcast();

  // Recurar los datos del Stream 
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream;

  // Insertar datos al Stream
  Function(String) get emailChange => _emailController.sink.add;
  Function(String) get passwordChange => _passwordController.sink.add;

  dispose(){

    _emailController?.close();
    _passwordController?.close();

  }


}