import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<FirebaseUser> getCurrentUser();
  Future<void> signOut();
  Future<String> signInWithGoogle();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = new GoogleSignIn();

  @override
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final FirebaseUser user =
          (await _firebaseAuth.signInWithCredential(credential)).user;
      
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      assert(user.uid == currentUser.uid);
      return user.uid;
    }
    return '';
  }

  @override
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
