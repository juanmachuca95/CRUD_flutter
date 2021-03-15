import 'package:flutter/material.dart';
import 'package:fluttercrud/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.photo_size_select_actual ),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon( Icons.camera_alt ), 
            onPressed: (){} 
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _crearPrecio(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    ); 
  }

  Widget _crearNombre(){

    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      validator: (value){
        if( value.length < 3 ){
          return 'Ingresa el nombre del producto . . .';
        }else{
          return null;
        }
      },
    );

  }

  Widget _crearPrecio(){

    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal:true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      validator: (value){

        return ( utils.isNumeric( value )) ? null : 'Solo números';

      },

    );

  }

  Widget _crearBoton(){

    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      child: Text('Guardar', style: TextStyle( color: Colors.white ) ),
      onPressed: _submit,
    );
  }

  void _submit(){

    if(!formKey.currentState.validate()) return;

    print("Todo okay");

  }
}
