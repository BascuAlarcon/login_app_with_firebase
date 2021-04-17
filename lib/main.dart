import 'package:ejercicio_3/pages/home.dart';
import 'package:ejercicio_3/pages/login_usuarios.dart';
import 'package:ejercicio_3/pages/base.dart';
import 'package:ejercicio_3/pages/registrar_usuarios.dart';
import 'package:ejercicio_3/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().usuario,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: Base()),
    );
  }
}
