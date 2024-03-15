import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final userCredentials = await _auth.signInWithCredential(authCredential);
    final User? user = userCredentials.user;

    //Applying checks:
    if (user != null && await user.getIdToken() != null) {
      final User? currentUser = await _auth.currentUser;

      assert(currentUser!.uid == user!.uid);

      //User verified
      print("User Verified");
      print(user);
      return user;
    } else {
      return null;
    }
  } catch (error) {
    print(error);
    return null;
  }
}
