import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keep_notes/services/sharedPrefrences.dart';

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
      //Saving the data in the LocalDataSaver:
      LocalDataSaver.saveImage(user.photoURL!);
      LocalDataSaver.saveName(user.displayName!);
      LocalDataSaver.saveEmail(user.email!);
      LocalDataSaver.saveLoginState(true);

      print("Printing the Data From the localDataSaver..................");
      getData();

      return user;
    } else {
      return null;
    }
  } catch (error) {
    print(error);
    return null;
  }
}

Future<bool?> signOut() async {
  try {
    await googleSignIn.signOut();
    await _auth.signOut();
    print("${LocalDataSaver.getLoginState()}");
    LocalDataSaver.saveLoginState(false);
    print(
        "Currently found in SignOut Implementation:..................... Signed Out");

    return true; // Return true when sign-out is successful
  } catch (error) {
    print("Error found in SignOut Implementation:.....................$error");
    // If sign-out fails, return false or null based on your requirement
    return false; // Or return null if you want to indicate failure with null
  }
}

void getData() async {
  String? name = await LocalDataSaver.getName();
  String? email = await LocalDataSaver.getEmail();
  String? image = await LocalDataSaver.getImage();
  bool? isLogin = await LocalDataSaver.getLoginState();

  print('Name: $name');
  print('Email: $email');
  print('Image: $image');
  print('IsLogin: $isLogin');
}
