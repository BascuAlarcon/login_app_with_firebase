import 'package:ejercicio_3/pages/home.dart';
import 'package:ejercicio_3/pages/login_usuarios.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Base extends StatelessWidget {
  const Base({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<User>(context);

    return usuario == null ? LoginUsuario() : Home();
  }
}
