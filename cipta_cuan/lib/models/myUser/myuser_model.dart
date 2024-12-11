import 'package:cipta_cuan/models/myUser/myuser_entity.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  final DateTime tanggalDibuat;
  final int avatar;
  final int saldo;
  final int pengeluaran;
  
  MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.tanggalDibuat,
    this.avatar = 1,
    required this.saldo,
    required this.pengeluaran,
  });

  static final empty = MyUser(
    id: '',
    email: '',
    name: '',
    tanggalDibuat: DateTime.now(),
    avatar: 1,
    saldo: 0,
    pengeluaran: 0,
  );

  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? tanggalDibuat,
    int? avatar,
    int? saldo,
    int? pengeluaran,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      tanggalDibuat: tanggalDibuat ?? this.tanggalDibuat,
      avatar: avatar ?? this.avatar,
      saldo: saldo ?? this.saldo,
      pengeluaran: pengeluaran ?? this.pengeluaran,
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
      avatar: avatar,
      saldo: saldo,
      pengeluaran: pengeluaran,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      tanggalDibuat: entity.tanggalDibuat,
      avatar: entity.avatar,
      saldo: entity.saldo,
      pengeluaran: entity.pengeluaran,
    );
  }

  @override
  List<Object?> get props => [id, email, name, tanggalDibuat, avatar, saldo, pengeluaran];
}
