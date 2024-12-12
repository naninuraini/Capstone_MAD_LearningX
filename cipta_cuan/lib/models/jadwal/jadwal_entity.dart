import 'package:cloud_firestore/cloud_firestore.dart';
import '../myUser/myuser_entity.dart';
import '../myUser/myuser_model.dart';

class JadwalEntity {
  String jadwalId;
  DateTime tanggalDanWaktu;
  int jumlah;
  String judul;
  String deskripsi;
  MyUser myUser;
  DateTime tanggalDitambahkan;

  JadwalEntity({
    required this.jadwalId,
    required this.tanggalDanWaktu,
    required this.jumlah,
    required this.judul,
    required this.deskripsi,
    required this.myUser,
    required this.tanggalDitambahkan,
  });

  Map<String, Object?> toDocument() {
    return {
      'jadwalId': jadwalId,
      'tanggalDanWaktu': tanggalDanWaktu,
      'jumlah': jumlah,
      'judul': judul,
      'deskripsi': deskripsi,
      'myUser': myUser.toEntity().toDocument(),
      'tanggalDitambahkan': tanggalDitambahkan,
    };
  }

  Map<String, Object?> toEditDocument(String newName, String newNpm) {
    return {
      'jadwalId': jadwalId,
      'tanggalDanWaktu': tanggalDanWaktu,
      'jumlah': jumlah,
      'judul': judul,
      'deskripsi': deskripsi,
      'myUser': myUser.toEntity().toDocument(),
      'tanggalDitambahkan': tanggalDitambahkan,
    };
  }

  static JadwalEntity fromDocument(Map<String, dynamic> data) {
    return JadwalEntity(
      jadwalId: data['jadwalId'] as String,
      tanggalDanWaktu: (data['tanggalDanWaktu'] as Timestamp).toDate(),
      jumlah: data['jumlah'] as int,
      judul: data['judul'] as String,
      deskripsi: data['deskripsi'] as String,
      myUser: MyUser.fromEntity(MyUserEntity.fromDocument(data['myUser'])),
      tanggalDitambahkan: (data['tanggalDitambahkan'] as Timestamp).toDate(),
    );
  }

  List<Object?> get props => [
        jadwalId,
        tanggalDanWaktu,
        jumlah,
        judul,
        deskripsi,
        myUser,
        tanggalDitambahkan
      ];

  @override
  String toString() {
    return '''PostEntity: {
      jadwalId: $jadwalId
      tanggalDanWaktu: $tanggalDanWaktu
      jumlah: $jumlah
      judul: $judul
      deskripsi: $deskripsi
      myUser: $myUser
      tanggalDitambahkan: $tanggalDitambahkan
    }''';
  }
}
