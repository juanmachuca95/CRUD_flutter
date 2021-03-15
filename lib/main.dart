import 'package:flutter/material.dart';
import 'package:fluttercrud/src/bloc/provider.dart';
import 'package:fluttercrud/src/pages/home_page.dart';
import 'package:fluttercrud/src/pages/login_page.dart';
import 'package:fluttercrud/src/pages/producto_page.dart';
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter CRUD',
        initialRoute: 'home',

        /**Mis Rutas */
        routes: <String, WidgetBuilder>{
          'login'     : ( BuildContext context ) =>  LoginPage(),
          'home'      : ( BuildContext context ) =>  HomePage(),
          'producto'  : ( BuildContext context ) => ProductoPage(),
        }
      )
    );
  }
}