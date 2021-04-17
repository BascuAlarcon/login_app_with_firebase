import 'package:ejercicio_3/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrarUsuario extends StatefulWidget {
  RegistrarUsuario({Key key}) : super(key: key);

  @override
  _RegistrarUsuarioState createState() => _RegistrarUsuarioState();
}

class _RegistrarUsuarioState extends State<RegistrarUsuario> {
  // CONTROLLERS //
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController password2Ctrl = TextEditingController();

  // VALIDATIONS //
  final _formKey = GlobalKey<FormState>(); // la llave va al inicio del form
  final _emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  String error = '';

  // PROGRESS BAR //
  bool loading = false;

  // BODY //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Usuario')),
      body: Center(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    _txtEmail(),
                    _txtPassword(),
                    _txtPassword2(),
                    _btnRegistrar(),
                    _textError(),
                    _mostrarLoading(),
                  ],
                ),
              ))),
    );
  }

  // FORMS FIELDS //
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

  Widget _txtPassword2() {
    return TextFormField(
      controller: password2Ctrl,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'confirmar contraseña',
          suffixIcon: Icon(FontAwesomeIcons.key)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Indique contraseña';
        }
        if (value != passwordCtrl.text) {
          return 'Las contraseñas no coinciden';
        }
        return null;
      },
    );
  }

  Widget _btnRegistrar() {
    return Container(
      child: RaisedButton(
        child: Text('REGISTRAR USUARIO'),
        onPressed: () {
          AuthService authService = new AuthService();
          if (_formKey.currentState.validate()) {
            setState(() {
              loading = true;
            });
            authService
                .crearUsuarios(emailCtrl.text.trim(), passwordCtrl.text.trim())
                .then((valor) {
              Navigator.pop(context);
            }).catchError((ex) {
              print('Última fase completada');
              setState(() {
                loading = false;
                error = ex;
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
