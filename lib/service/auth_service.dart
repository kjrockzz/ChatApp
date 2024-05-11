import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj1/helper/helper_func.dart';
import 'package:proj1/service/database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //login

  Future loginWithUserNameandPassword(
       String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }



  //register
  Future registerUserWithEmailAndPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);
        //call database service to update user data
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //signout

  Future signOut() async {
    try
    {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserNameSF("");
      await HelperFunctions.saveUserEmailSF("");
      await firebaseAuth.signOut();
    }
    catch(e){
      return null;
    }
  }
}
