import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../style/color.dart';

class Auth{
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> login(
    {required String email, required String password}
      ) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Something wrong!', colorText: kDeepSeaBlue, duration: Duration(seconds: 5), backgroundColor: kWhite,);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(
    {required String email, required String password}
      ) async {
    try{
       await _auth.createUserWithEmailAndPassword(
          email: email, password: password
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Something wrong!', colorText: kDeepSeaBlue, duration: Duration(seconds: 5), backgroundColor: kWhite,);
    } catch (e){
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.snackbar('Keluar', 'Anda berhasil keluar.', colorText: kDeepSeaBlue, duration: Duration(seconds: 5), backgroundColor: kWhite,);
  }

  Future<UserCredential> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
