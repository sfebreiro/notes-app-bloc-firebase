import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/entities/entities.dart';
import 'package:notes_app/models/user_model.dart';
import 'package:notes_app/repositories/repositories.dart';
import 'package:notes_app/config/paths.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseFirestore firestore, FirebaseAuth firebaseAuth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  void dispose() {}

  Future<UserC> _firebaseUserToUser(User user) async {
    DocumentSnapshot userDoc =
        await _firestore.collection(Paths.users).doc(user.uid).get();

    if (userDoc.exists) {
      UserC user = UserC.fromEntity(UserEntity.fromSnapshot(userDoc));
      return user;
    }
    return UserC(
      id: user.uid,
      email: '',
    );
  }

  @override
  Future<UserC> loginAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return await _firebaseUserToUser(authResult.user);
  }

  @override
  Future<UserC> signupWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    final currentUser = _firebaseAuth.currentUser; // await -> currentUser();
    final authCredential =
        EmailAuthProvider.credential(email: email, password: password);
    final authResult = await currentUser.linkWithCredential(authCredential);
    final user = await _firebaseUserToUser(authResult.user);
    _firestore
        .collection(Paths.users)
        .doc(user.id)
        .set(user.toEntity().toDocument());
    return user;
  }

  @override
  Future<UserC> loginWithEmailAndPassword(
      {@required String email, @required String password}) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return await _firebaseUserToUser(authResult.user);
  }

  @override
  Future<UserC> logout() async {
    await _firebaseAuth.signOut();
    return await loginAnonymously();
  }

  @override
  Future<UserC> getCurrentUser() async {
    final currentUser = _firebaseAuth.currentUser; // await -> currentUser();
    if (currentUser == null) return null;
    return await _firebaseUserToUser(currentUser);
  }

  @override
  Future<bool> isAnonymous() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser.isAnonymous;
  }
}
