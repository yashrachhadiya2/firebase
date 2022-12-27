import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<String> signUp(String e1, String p1) async {
  try {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.createUserWithEmailAndPassword(email: e1, password: p1);
    return "Success";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("password at list 6 char");
      return "password at list 6 char";
    } else if (e.code == "email-already-in-use") {
      print("Email already Exist");
      return "Email alredy Exist";
    }
  }
  return "";
}

Future<String> loginEmailPassword(String email, String password) async {
  try {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return "Success";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return "No user found for that email.";
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return "Wrong password provided for that user.";
    }
  }
  return "";
}

bool checkUser() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return true;
  }
  return false;
}

void logout() {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  firebaseAuth.signOut();
}

Future<bool> googleLogin() async {
  GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
  GoogleSignInAuthentication? googleSignInAuthentication =
  await googleSignInAccount?.authentication;
  var credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication!.accessToken,
      idToken: googleSignInAuthentication!.idToken);
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  await firebaseAuth.signInWithCredential(credential);

  return checkUser();
}

Future<List> userProfile() async {
  User? user = await FirebaseAuth.instance.currentUser;
  return [
    user!.email,
    user.displayName,
    user.photoURL,
    user.uid,
  ];
}

void insertData(String id, String name, String mobile, String std) {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = firebaseFirestore.collection(
      "Student");

  collectionReference.add(
      {"id": "$id", "name": "$name", "mobile": "$mobile", "std": "$std"}).then((
      value) => print("Success")).catchError((errore) =>
      print("Errore $errore"));
}

Stream<QuerySnapshot<Map<String, dynamic>>> readData(){
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  return firebaseFirestore.collection("Student").snapshots();
}

void deleteData(String key){
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore.collection("Student").doc("$key").delete();
}

void updateData(String key,String id , String name,String mobile,String std){
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  firebaseFirestore.collection("Student").doc("$key").set({"id":"$id","name":"$name","std":"$std","mobile":"$mobile"});
}

// void initNotification()async{
//   flnp = FlutterLocalNotificationsPlugin();
//
//   AndroidInitializationSettings androidSettings = AndroidInitializationSettings("")
// }

