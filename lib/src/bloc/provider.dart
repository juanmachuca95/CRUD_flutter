import 'package:flutter/material.dart';
import 'package:fluttercrud/src/bloc/login_block.dart';
export 'package:fluttercrud/src/bloc/login_block.dart';

class Provider extends InheritedWidget {

  static Provider _instancia;

  factory Provider({ Key key, Widget child }){

    if(_instancia == null){

      _instancia = new Provider._internal( key:key, child:child );

    }

    return _instancia;
  }

  final loginBloc = LoginBloc();

   Provider._internal({ Key key, Widget child })
    : super( key: key, child: child );

  /*   Provider()
    : super( key: key, child: child );
  */
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

}