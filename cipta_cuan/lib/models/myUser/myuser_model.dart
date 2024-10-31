import 'package:cipta_cuan/models/myUser/myuser_entity.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  final DateTime tanggalDibuat;

  MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.tanggalDibuat,
  });

  static final empty = MyUser(
    id: '',
    email: '',
    name: '',
    tanggalDibuat: DateTime.now(),
  );

  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? tanggalDibuat,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      tanggalDibuat: tanggalDibuat ?? this.tanggalDibuat,
    );
  }

  bool get isEmpty => this == MyUser.empty;

  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      email: email,
      name: name,
      tanggalDibuat: tanggalDibuat,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      tanggalDibuat: entity.tanggalDibuat,
    );
  }

  @override
  List<Object?> get props => [id, email, name, tanggalDibuat];
}
