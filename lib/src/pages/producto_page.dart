import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttercrud/src/providers/productos_provider.dart';
import 'package:fluttercrud/src/utils/utils.dart' as utils;
import 'package:fluttercrud/src/models/producto_model.dart';
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  
  final formKey           = GlobalKey<FormState>();
  final scaffoldKey       = GlobalKey<ScaffoldState>();
  final productoProvider = new ProductosProvider();
  ProductoModel producto = new ProductoModel();
  bool action = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    
    final arguments = ModalRoute.of(context).settings.arguments;
    
    if(arguments != null){
      producto = arguments;
      action = true;
    }else {
      setState((){
        producto = new ProductoModel();
      });
    }
    print(producto);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.photo_size_select_actual ),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon( Icons.camera_alt ), 
            onPressed: _tomarFoto, 
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
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
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
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value) {producto.titulo = value;},
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
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal:true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      validator: (value){

        return ( utils.isNumeric( value )) ? null : 'Solo números';

      },
      onSaved: (value) => producto.valor = double.parse(value),

    );
  }


  Widget _crearDisponible(){

    return SwitchListTile(
      value: (producto != null ) ? producto.disponible : false,
      title: Text('Disponible'),
      onChanged: ( value )
        {producto.disponible = value; }
      
    );

  }


  Widget _crearBoton(){

    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      child: Text((!action) ? 'Crear' : 'Editar', style: TextStyle( color: Colors.white ) ),
      onPressed: _submit,
    );
  }

  void _submit(){

    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    if( !action ){

      productoProvider.crearProducto(producto); 
      mostrarSnackbar("Se ha creado un nuevo producto correctamente.");

    } else{

      productoProvider.editarProducto(producto);
      mostrarSnackbar("Se ha editado correctamente un producto.");

    }    

  

  }

  void mostrarSnackbar( String mensaje ){

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text( mensaje ),
      duration: const Duration( milliseconds: 1500 ),
      action: SnackBarAction(
        label: 'Ir a home',
        onPressed: () {
          Navigator.pushNamed( context, 'home' );
        },
      ),
    ));
  }

  _mostrarFoto(){

    if(producto.fotoUrl != null){
      
      return Container(

      );

    }else{

       if( foto != null ){
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');

    }

  }


  Future _seleccionarFoto() async {
    _procesarImage( ImageSource.gallery );
  }

  _tomarFoto() async {
   _procesarImage( ImageSource.camera );
  }


  _procesarImage(ImageSource tipo) async {
    
    final _picker  = ImagePicker();
    final _pickedFile = await _picker.getImage(
      
      source: tipo, 
    
    );

    try {
      foto = File( _pickedFile.path );
    } catch (e) {
      print('$e');
    }

    if( foto != null ){
      //Limpieza
    } 

    setState((){});
  }

}
