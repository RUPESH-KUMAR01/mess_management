
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/entities/entites.dart';
import 'package:user_repository/src/models/my_user.dart';
import 'package:user_repository/src/user_repo.dart';

class FirebaseUserRepository implements UserRepository{
FirebaseUserRepository({
  FirebaseAuth? firebaseAuth,
}):_firebaseAuth=firebaseAuth??FirebaseAuth.instance;


final UsersCollection=FirebaseFirestore.instance.collection('users');
final FirebaseAuth _firebaseAuth;

  @override
  Future<void> LogOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    // TODO: implement resetPassword
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    // TODO: implement signIn
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password);
    }
    catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    // TODO: implement signUp
    try{
      UserCredential user=await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
         password: password);
      myUser=myUser.copyWith(id: user.user!.uid);
      return myUser;
    }catch(e){
      log(e.toString());
      rethrow;
    }
  }
  
@override
Future<MyUser> getMyUser(String myUserId) async {
    try {
      return UsersCollection.doc(myUserId).get().then((value) =>
				MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!))
			);
    } catch (e) {
			log(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<void> setUserData(MyUser myuser) async {
    // TODO: implement setUserData
    try {
      await UsersCollection.doc(myuser.id).set(myuser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  @override
  // TODO: implement user
  Stream<User?> get user{
    return _firebaseAuth.authStateChanges().map((
      firebaseUser){
        final user=firebaseUser;
        return user;
    } );
  }

  Stream<MyUser>  userdetails(String MyUserId){
    return UsersCollection.doc(MyUserId).snapshots().map((val) => MyUser.fromEntity(MyUserEntity.fromDocument(val.data()!)));
  }
}