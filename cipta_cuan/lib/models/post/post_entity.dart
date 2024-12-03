import 'package:cloud_firestore/cloud_firestore.dart';
import '../myUser/myuser_entity.dart';
import '../myUser/myuser_model.dart';

class PostEntity {
  String postId;
  DateTime tanggal;
    String kategori;
  String jumlah;
  String judul;
  String deskripsi;
  String gambar;
  MyUser myUser;
  DateTime tanggalDitambahkan;

  PostEntity({
    required this.postId,
    required this.tanggal,
    required this.kategori,
    required this.jumlah,
    required this.judul,
    required this.deskripsi,
    required this.gambar,
    required this.myUser,
    required this.tanggalDitambahkan,
  });

  Map<String, Object?> toDocument() {
    return {
      'postId': postId,
      'tanggal': tanggal,
      'kategori': kategori,
      'jumlah': jumlah,
      'judul': judul,
      'deskripsi': deskripsi,
      'gambar': gambar,
      'myUser': myUser.toEntity().toDocument(),
      'tanggalDitambahkan': tanggalDitambahkan,
    };
  }

  Map<String, Object?> toEditDocument(String newName, String newNpm) {
    return {
      'postId': postId,
      'tanggal': tanggal,
      'kategori': kategori,
      'jumlah': jumlah,
      'judul': judul,
      'deskripsi': deskripsi,
      'gambar': gambar,
      'myUser': myUser.toEntity().toDocument(),
      'tanggalDitambahkan': tanggalDitambahkan,
    };
  }

  static PostEntity fromDocument(Map<String, dynamic> data, String myUserId) {
    return PostEntity(
        postId: data['postId'] as String,
        tanggal: (data['tanggal'] as Timestamp).toDate(),
        kategori: data['kategori'] as String,
        jumlah: data['jumlah'] as String,
        judul: data['judul'] as String,
        deskripsi: data['deskripsi'] as String,
        gambar: data['gambar'] as String,
        myUser: MyUser.fromEntity(MyUserEntity.fromDocument(data['myUser'])),
        tanggalDitambahkan: (data['tanggalDitambahkan'] as Timestamp).toDate(),
        );
  }

  List<Object?> get props => [postId, tanggal, kategori, jumlah, judul, deskripsi, gambar, myUser, tanggalDitambahkan];

  @override
  String toString() {
    return '''PostEntity: {
      postId: $postId
      tanggal: $tanggal
      kategori: $kategori
      jumlah: $jumlah
      judul: $judul
      deskripsi: $deskripsi
      gambar: $gambar
      myUser: $myUser
      tanggalDitambahkan: $tanggalDitambahkan
    }''';
  }
}
