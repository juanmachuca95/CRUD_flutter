import 'dart:async';
import 'package:fluttercrud/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc with Validators{ // Aplicando Mixins para utilizar la validacion del componente Validator

  /* 
  final _emailController = new StreamController<String>.broadcast();
  final _passwordController = new StreamController<String>.broadcast();
  */

  final _emailController = new BehaviorSubject<String>();
  final _passwordController = new BehaviorSubject<String>();
  
  // Recurar los datos del Stream 
  Stream<String> get emailStream => _emailController.stream.transform( validarEmail );
  Stream<String> get passwordStream => _passwordController.stream.transform( validarPassword );

  Stream<bool> get formValidStream =>
    Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar datos al Stream
  Function(String) get emailChange => _emailController.sink.add;
  Function(String) get passwordChange => _passwordController.sink.add;


  dispose(){

    _emailController?.close();
    _passwordController?.close();

  }


}