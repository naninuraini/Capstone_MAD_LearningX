import '../myUser/myuser_model.dart';
import 'post_entity.dart';

class Post {
  String postId;
  DateTime tanggal;
  String kategori;
  int jumlah;
  String judul;
  String deskripsi;
  String gambar;
  MyUser myUser;
  DateTime tanggalDitambahkan;

  Post({
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

  static final empty = Post(
    postId: '',
    tanggal: DateTime.now(),
    kategori: '',
    jumlah: 0,
    judul: '',
    deskripsi: '',
    gambar: '',
    myUser: MyUser.empty,
    tanggalDitambahkan: DateTime.now(),
  );

  Post copyWith({
    String? postId,
    DateTime? tanggal,
    String? kategori,
    int? jumlah,
    String? judul,
    String? deskripsi,
    String? gambar,
    MyUser? myUser,
    DateTime? tanggalDitambahkan,
  }) {
    return Post(
      postId: postId ?? this.postId,
      tanggal: tanggal ?? this.tanggal,
      kategori: kategori ?? this.kategori,
      jumlah: jumlah ?? this.jumlah,
      judul: judul ?? this.judul,
      deskripsi: deskripsi ?? this.deskripsi,
      gambar: gambar ?? this.gambar,
      myUser: myUser ?? this.myUser,
      tanggalDitambahkan: tanggalDitambahkan ?? this.tanggalDitambahkan,
    );
  }

  bool get isEmpty => this == Post.empty;

  bool get isNotEmpty => this != Post.empty;

  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      tanggal: tanggal,
      kategori: kategori,
      jumlah: jumlah,
      judul: judul,
      deskripsi: deskripsi,
      gambar: gambar,
      myUser: myUser,
      tanggalDitambahkan: tanggalDitambahkan,
    );
  }

  static Post fromEntity(PostEntity entity) {
    return Post(
      postId: entity.postId,
      tanggal: entity.tanggal,
      kategori: entity.kategori,
      jumlah: entity.jumlah,
      judul: entity.judul,
      deskripsi: entity.deskripsi,
      gambar: entity.gambar,
      myUser: entity.myUser,
      tanggalDitambahkan: entity.tanggalDitambahkan,
    );
  }

  @override
  String toString() {
    return '''Post: {
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
