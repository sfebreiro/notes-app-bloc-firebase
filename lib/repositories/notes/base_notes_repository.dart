import 'package:notes_app/repositories/repositories.dart';
import 'package:notes_app/models/models.dart';

abstract class BaseNotesRepositoty extends BaseRepository {
  Future<Note> addNote({Note note});
  Future<Note> updateNote({Note note});
  Future<Note> deleteNote({Note note});
  Stream<List<Note>> streamNote({String userId});
}
