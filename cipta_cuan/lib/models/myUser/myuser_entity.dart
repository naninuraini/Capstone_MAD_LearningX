import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final DateTime tanggalDibuat;
  final String avatar;

  const MyUserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.tanggalDibuat,
    required this.avatar,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'tanggalDibuat': tanggalDibuat,
      'avatar': avatar,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
      email: doc['email'] as String,
      name: doc['name'] as String,
      tanggalDibuat: doc['tanggalDibuat'] != null
        ? (doc['tanggalDibuat'] as Timestamp).toDate()
        : DateTime.now(), 
      avatar: doc['avatar'] as String,
    );
  }

  @override
  List<Object?> get props => [id, email, name, tanggalDibuat, avatar];

  // @override
  // String toString() {
  //   return '''UserEntity: {
  //     id: $id
  //     email: $email
  //     name: $name
  //     tanggalDibuat: $tanggalDibuat
  //   }''';
  // }
}
