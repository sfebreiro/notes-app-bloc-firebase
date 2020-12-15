import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/entities/entities.dart';

class UserC extends Equatable {
  final String id;
  final String email;

  UserC({
    @required this.id,
    @required this.email,
  });

  @override
  List<Object> get props => [id, email];

  @override
  String toString() => ''' User {
    id: $id,
    email: $email
    }''';

  UserEntity toEntity() {
    return UserEntity(id: id, email: email);
  }

  factory UserC.fromEntity(UserEntity entity) {
    return UserC(id: entity.id, email: entity.email);
  }
}
