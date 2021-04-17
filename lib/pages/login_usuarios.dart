import 'package:ejercicio_3/pages/registrar_usuarios.dart';
import 'package:ejercicio_3/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginUsuario extends StatefulWidget {
  LoginUsuario({Key key}) : super(key: key);

  @override
  _LoginUsuarioState createState() => _LoginUsuarioState();
}

class _LoginUsuarioState extends State<LoginUsuario> {
  // CONTROLLERS //
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  // VALIDATIONS //
  final _formKey = GlobalKey<FormState>(); // la llave va al inicio del form
  final _emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  String error = ' ';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    _txtEmail(),
                    _txtPassword(),
                    _btnLogin(),
                    _textError(),
                    _mostrarLoading(),
                    Container(
                      child: FlatButton(
                          onPressed: () {
                            final route = MaterialPageRoute(
                                builder: (context) => RegistrarUsuario());
                            Navigator.push(context, route);
                          },
                          child: Text(
                            'Crear Cuenta',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          )),
                    )
                  ],
                ),
              ))),
    );
  }

  Widget _txtEmail() {
    return TextFormField(
      controller: emailCtrl,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'email', suffixIcon: Icon(FontAwesomeIcons.envelope)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Indique Email';
        }
        if (!RegExp(_emailRegex).hasMatch(value)) {
          return 'Email no valido';
        }
        return null;
      },
    );
  }

  Widget _txtPassword() {
    return TextFormField(
      controller: passwordCtrl,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'contraseña', suffixIcon: Icon(FontAwesomeIcons.key)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Indique contraseña';
        }
        if (value.length < 6) {
          return 'Debe contener al menos 6 cáracteres';
        }
        return null;
      },
    );
  }

  Widget _btnLogin() {
    return Container(
      child: RaisedButton(
        child: Text('INICIAR SESION'),
        onPressed: () {
          AuthService authService = new AuthService();
          if (_formKey.currentState.validate()) {
            setState(() {
              loading = true;
            });
            authService
                .iniciarSesionUsuario(
                    emailCtrl.text.trim(), passwordCtrl.text.trim())
                .catchError((exError) {
              setState(() {
                loading = false;
                error = exError;
              });
            });
          }
        },
      ),
    );
  }

  Widget _textError() {
    return Center(
      child: Container(
          margin: EdgeInsets.only(top: 8),
          child: Text(error, style: TextStyle(color: Colors.red))),
    );
  }

  Widget _mostrarLoading() {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Text('');
  }
}
