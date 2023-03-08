import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  static final auth=FirebaseAuth.instance;
  static User? get currentUser=>auth.currentUser;
  static Future<bool> login(String email,String password) async {
    final credential =await auth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user!=null;
  }
  static Future<UserCredential> register(String email,String password)async{
    final credential =await auth.createUserWithEmailAndPassword(email: email, password: password);
    return credential;
  }
  static Future<void> logout() => auth.signOut();
}