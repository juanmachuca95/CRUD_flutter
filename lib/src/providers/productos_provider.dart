import 'package:http/http.dart' as http;
import 'package:fluttercrud/src/models/producto_model.dart';
import 'dart:convert';


class ProductosProvider{

  final String _url = "https://flutter-b4d79-default-rtdb.firebaseio.com";


  Future<bool> crearProducto( ProductoModel producto ) async {

    final String url = '$_url/productos.json';

    final resp = await http.post( Uri.parse(url) , body:productoModelToJson(producto) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;
  
  }

  Future<bool> editarProducto( ProductoModel producto ) async {

    final String url = '$_url/productos/${ producto.id }.json';

    final resp = await http.put( Uri.parse(url) , body:productoModelToJson(producto) );
 
    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;
  
  }

  Future<List<ProductoModel>> cargarProductos() async {

    final url = Uri.parse('$_url/productos.json');

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    
    if( decodedData == null ) return [];

    final List<ProductoModel> productos = [];   
    //print(decodedData);

    decodedData.forEach( ( id, prod ){

      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
    
      productos.add( prodTemp );

    });

    return productos;
  }


  Future<int> borrarProducto( String id ) async {

    final url = '$_url/productos/$id.json';
    
    final resp = await http.delete(Uri.parse(url));

    print( json.decode(resp.body) );

    return 1;
  }
}