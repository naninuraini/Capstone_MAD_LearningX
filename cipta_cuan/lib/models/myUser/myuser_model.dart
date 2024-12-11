import 'package:cipta_cuan/models/myUser/myuser_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MyUser extends Equatable {
  static const String defaultAvatar = 'assets/images/Avatar1.png';

  final String id;
  final String email;
  final String name;
  final DateTime tanggalDibuat;
  final String avatar;
  final int saldo;
  final int pengeluaran;
  
  MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.tanggalDibuat,
    this.avatar = defaultAvatar,
    required this.saldo,
    required this.pengeluaran,
  });

  static final empty = MyUser(
    id: '',
    email: '',
    name: '',
    tanggalDibuat: DateTime.now(),
    avatar: defaultAvatar,
    saldo: 0,
    pengeluaran: 0,
  );

  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? tanggalDibuat,
    String? avatar,
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

  factory MyUser.fromDocument(Map<String, dynamic> data) {
    return MyUser(
      id: data['id'] ?? '',  
      email: data['email'] ?? '',
      name: data['name'] ?? 'Nama tidak ditemukan',
      tanggalDibuat: (data['tanggalDibuat'] as Timestamp).toDate(),
      avatar: data['avatar'] ?? defaultAvatar,  
      saldo: data['saldo'] ?? 0,  
      pengeluaran: data['pengeluaran'] ?? 0,  
    );
  }

  @override
  List<Object?> get props => [id, email, name, tanggalDibuat, avatar, saldo, pengeluaran];
}
