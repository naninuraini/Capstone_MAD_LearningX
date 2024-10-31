import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final DateTime tanggalDibuat;

  const MyUserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.tanggalDibuat,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'tanggal': tanggalDibuat,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
      email: doc['email'] as String,
      name: doc['name'] as String,
      tanggalDibuat: (doc['tanggalDibuat'] as Timestamp).toDate(),
    );
  }

  @override
  List<Object?> get props => [id, email, name, tanggalDibuat];

  @override
  String toString() {
    return '''UserEntity: {
      id: $id
      email: $email
      name: $name
      tanggalDibuat: $tanggalDibuat
    }''';
  }
}
