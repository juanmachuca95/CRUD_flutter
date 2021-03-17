import 'package:flutter/material.dart';
import 'package:fluttercrud/src/providers/productos_provider.dart';
import 'package:fluttercrud/src/utils/utils.dart' as utils;
import 'package:fluttercrud/src/models/producto_model.dart';

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  
  final formKey           = GlobalKey<FormState>();
  final scaffoldKey       = GlobalKey<ScaffoldState>();
  final productoProvider = new ProductosProvider();

  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {
    //ModalRoute.of(context).settings.arguments
    final ProductoModel prodData = new ProductoModel();
    if( producto != null ){
      producto = prodData;
    } 

    return Scaffold(
      key: scaffoldKey,
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
      initialValue: producto.titulo ?? '',
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value) => producto.titulo = value,
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
      initialValue: producto.valor.toString() ?? '',
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
      value: producto.disponible,
      title: Text('Disponible'),
      onChanged: ( value ) => setState((){
        producto.disponible = value;
      })
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

    formKey.currentState.save();

    print( producto.titulo );
    print( producto.valor );
    print( producto.disponible );
    print("Todo okay");


    if( producto == null ){

      productoProvider.crearProducto(producto); 

    }else{

      productoProvider.editarProducto(producto);

    }    

    mostrarSnackbar(" Se ha guardado exitosamente ");

  }

  void mostrarSnackbar( String mensaje ){

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text( mensaje ),
      duration: const Duration( milliseconds: 1500 ),
      action: SnackBarAction(
        label: 'ACTION',
        onPressed: () { },
      ),
    ));
  }

}
