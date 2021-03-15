import 'package:flutter/material.dart';
import 'package:fluttercrud/src/bloc/provider.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Home'),
      ),
      body: Container(),
      floatingActionButton: _crearBoton(context) 

    );
  }

  Widget _crearBoton(BuildContext context){

    return FloatingActionButton(
      child: Icon( Icons.add ),
      onPressed: () => Navigator.pushNamed(context, 'producto')
    );

  }

}

