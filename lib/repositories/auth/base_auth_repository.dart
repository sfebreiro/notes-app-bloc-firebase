import 'package:notes_app/models/models.dart';
import 'package:notes_app/repositories/repositories.dart';

abstract class BaseAuthRepository extends BaseRepository {
  Future<UserC> loginAnonymously();
  Future<UserC> signupWithEmailAndPassword({String email, String password});
  Future<UserC> loginWithEmailAndPassword({String email, String password});
  Future<UserC> logout();
  Future<UserC> getCurrentUser();
  Future<bool> isAnonymous();
}
