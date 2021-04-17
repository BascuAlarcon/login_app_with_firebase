import 'package:firebase_auth/firebase_auth.dart';

// a través de este objeto podremos acceder a los servicios de auth de firebase //
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get usuario {
    return _firebaseAuth.authStateChanges();
    //return _firebaseAuth.onAuthStateChanged;
  }

  // CREAR USERS //
  Future crearUsuarios(String email, String password) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = authResult.user;
      return firebaseUser;
    } catch (ex) {
      switch (ex.code) {
        case 'email-already-in-use':
          return Future.error('Email ya existente');
          break;
        case 'EMAIL-ALREADY-IN-USE':
          return Future.error('Email ya existente');
          break;
        case ' email-already-in-use':
          return Future.error('Email ya existente');
          break;
        default:
          return Future.error(ex.code);
      }
    }
  }

  // LOGIN //
  Future iniciarSesionUsuario(String email, String password) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser = authResult.user;
      return firebaseUser;
    } catch (ex) {
      if (ex.code == 'ERROR_WRONG_PASSWORD') {
        return Future.error('Credenciales incorrectas');
      }
      if (ex.code == 'user-not-found') {
        return Future.error('Credenciales incorrectas');
      }
      if (ex.code == 'user-disabled') {
        return Future.error('Cuenta deshabilitada');
      }
      return Future.error(ex.code);
    }
  }

  // LOGOUT //
  Future cerrarSesionUsuario() async {
    return await _firebaseAuth.signOut();
  }
}
