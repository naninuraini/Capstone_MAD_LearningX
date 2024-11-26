import 'package:cipta_cuan/models/myUser/myuser_entity.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MyUser extends Equatable {
  static const String defaultAvatar = 'assets/images/Avatar1.png';

  final String id;
  final String email;
  final String name;
  final DateTime tanggalDibuat;
  final String avatar;
  
  MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.tanggalDibuat,
    this.avatar = defaultAvatar,
  });

  static final empty = MyUser(
    id: '',
    email: '',
    name: '',
    tanggalDibuat: DateTime.now(),
    avatar: defaultAvatar,
  );

  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? tanggalDibuat,
    String? avatar,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      tanggalDibuat: tanggalDibuat ?? this.tanggalDibuat,
      avatar: avatar ?? this.avatar,
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
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      tanggalDibuat: entity.tanggalDibuat,
      avatar: entity.avatar,
    );
  }

  @override
  List<Object?> get props => [id, email, name, tanggalDibuat, avatar];
}
