import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthService(this._firebaseAuth, this._googleSignIn);

  // Đăng ký
  Future<User?> signUpWithEmail(
      String email, String password, String displayName,
      ) async{
    final UserCredential result =
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user;
    if (user == null) return null;

    await user.updateDisplayName(displayName);
    await user.reload();

    return _firebaseAuth.currentUser;
   }

  //Đăng nhập bằng Email
  Future<User?> signInWithEmail(
      String email, String password) async {
    final UserCredential result =
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  //Đăng nhập bằng Google
  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
    await _googleSignIn.signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential result =
    await _firebaseAuth.signInWithCredential(credential);

    return result.user;
  }

  //Reset password
  Future<void> resetPass(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);

  }

  //Đăng xuất
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
