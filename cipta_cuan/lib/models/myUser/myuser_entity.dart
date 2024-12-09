import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final DateTime tanggalDibuat;
  final String avatar;
  final int saldo;
  final int pengeluaran;

  const MyUserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.tanggalDibuat,
    required this.avatar,
    required this.saldo,
    required this.pengeluaran,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'tanggalDibuat': tanggalDibuat,
      'avatar': avatar,
      'saldo': saldo,
      'pengeluaran': pengeluaran,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      name: doc['name'] as String,
      id: doc['id'] as String,
      avatar: doc['avatar'] as String,
      saldo: doc['saldo'] as int,
      pengeluaran: doc['pengeluaran'] as int,
      tanggalDibuat: doc['tanggalDibuat'] != null
        ? (doc['tanggalDibuat'] as Timestamp).toDate()
        : DateTime.now(), 
      email: doc['email'] as String,
    );
  }

  @override
  List<Object?> get props => [id, email, name, tanggalDibuat, avatar, saldo, pengeluaran];

  @override
  String toString() {
    return '''UserEntity: {
      id: $id
      email: $email
      name: $name
      tanggalDibuat: $tanggalDibuat
      avatar: $avatar
      saldo: $saldo
      pengeluaran: $pengeluaran
    }''';
  }
}
