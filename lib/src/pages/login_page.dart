
import 'package:flutter/material.dart';
import 'package:fluttercrud/src/bloc/provider.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo( context ),
          _loginForm()
        ],
      )

    );
  }

  Widget _crearFondo(BuildContext context) {

    final size = MediaQuery.of( context ).size;

    final colorFondo = Container(
      height: size.height * 0.4, //40 % del dispositivo
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 63, 136, 1.0),
            Color.fromRGBO(90, 78, 178, 1.0)
          ]
        )
      ),
    );

    return Stack(children: <Widget>[

      colorFondo,
      Container(
        padding: EdgeInsets.only( top: 80.0 ),
        child: Column(
          children: [
            Icon( Icons.accessibility, color: Colors.white, size: 60.0 ),
            SizedBox( height: 10.0, width: double.infinity ), 
            Text( 'Juan Machuca', style: TextStyle( color: Colors.white, fontSize: 20.0 ) ),
          ],
        )
      )

    ],);

  }

  Widget _loginForm() {
    final bloc = Provider.of(context);
    final size = MediaQuery.of( context ).size;
    
    return SingleChildScrollView(
      child: Column(
        children: [

          SafeArea(
            child: Container(
              height: 180.0,
            ),
            
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            margin: EdgeInsets.only(top:20.0),
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0
                )
              ]
              
            ),
            child: Column(
              children: [
                Text('Ingreso', style: TextStyle( fontSize: 20.0 )),
                SizedBox( height: 20.0 ),
                _crearEmail( bloc ),
                SizedBox( height: 20.0 ),
                _crearPassword( bloc ),
                SizedBox( height: 20.0 ),
                _crearButton( bloc ) 
              ],
            ),
          )
          ,

          Text('¿Has olvidado la contraseña?'),
        ],
      )
    );

  }

  Widget _crearEmail( LoginBloc bloc ) {

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: ( BuildContext context, AsyncSnapshot snapshot ){
        return Container(
          padding: EdgeInsets.symmetric( horizontal: 20.0, vertical: 10.0 ),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Correo electronico . . .',
              labelText: 'Email',
              suffixIcon: Icon( Icons.alternate_email ),
              icon: Icon( Icons.email ),
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.emailChange,
          ),
        );
      }
    );    
  }

  Widget _crearPassword( LoginBloc bloc ) {

    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: ( BuildContext context, AsyncSnapshot snapshot ){
        return Container(
          padding: EdgeInsets.symmetric( horizontal: 20.0, vertical: 10.0 ),
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              hintText: 'Escribe tu contraseña . . .',
              labelText: 'Contraseña',
              suffixIcon: Icon( Icons.lock_open ),
              icon: Icon( Icons.lock_rounded),
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.passwordChange,
          ),
        );
      },
    );
  }


  Widget _crearButton( bloc ){
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: ( BuildContext context, AsyncSnapshot snapshot){
          return Container(
            padding: EdgeInsets.symmetric( horizontal: 40.0 ),
            child: MaterialButton(
              minWidth: double.infinity,
              padding: EdgeInsets.all( 20.0 ),
              color: Colors.blue,
              child: Text('Ingresar', style: TextStyle( color: Colors.black )),
              onPressed: (!snapshot.hasData) ? null: (){},
            ),
          );
        },
    );
  }
}
