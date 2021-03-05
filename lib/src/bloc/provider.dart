import 'package:flutter/material.dart';
import 'package:fluttercrud/src/bloc/login_block.dart';
export 'package:fluttercrud/src/bloc/login_block.dart';

class Provider extends InheritedWidget {

  final loginBloc = LoginBloc();

  Provider({ Key key, Widget child })
    : super( key: key, child: child );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

}