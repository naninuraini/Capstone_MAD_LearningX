import '../myUser/myuser_model.dart';
import 'jadwal_entity.dart';

class Jadwal {
  String jadwalId;
  DateTime tanggalDanWaktu;
  int jumlah;
  String judul;
  String deskripsi;
  MyUser myUser;
  DateTime tanggalDitambahkan;

  Jadwal({
    required this.jadwalId,
    required this.tanggalDanWaktu,
    required this.jumlah,
    required this.judul,
    required this.deskripsi,
    required this.myUser,
    required this.tanggalDitambahkan,
  });

  static final empty = Jadwal(
    jadwalId: '',
    tanggalDanWaktu: DateTime.now(),
    jumlah: 0,
    judul: '',
    deskripsi: '',
    myUser: MyUser.empty,
    tanggalDitambahkan: DateTime.now(),
  );

  Jadwal copyWith({
    String? jadwalId,
    DateTime? tanggalDanWaktu,
    int? jumlah,
    String? judul,
    String? deskripsi,
    MyUser? myUser,
    DateTime? tanggalDitambahkan,
  }) {
    return Jadwal(
      jadwalId: jadwalId ?? this.jadwalId,
      tanggalDanWaktu: tanggalDanWaktu ?? this.tanggalDanWaktu,
      jumlah: jumlah ?? this.jumlah,
      judul: judul ?? this.judul,
      deskripsi: deskripsi ?? this.deskripsi,
      myUser: myUser ?? this.myUser,
      tanggalDitambahkan: tanggalDitambahkan ?? this.tanggalDitambahkan,
    );
  }

  bool get isEmpty => this == Jadwal.empty;

  bool get isNotEmpty => this != Jadwal.empty;

  JadwalEntity toEntity() {
    return JadwalEntity(
      jadwalId: jadwalId,
      tanggalDanWaktu: tanggalDanWaktu,
      jumlah: jumlah,
      judul: judul,
      deskripsi: deskripsi,
      myUser: myUser,
      tanggalDitambahkan: tanggalDitambahkan,
    );
  }

  static Jadwal fromEntity(JadwalEntity entity) {
    return Jadwal(
      jadwalId: entity.jadwalId,
      tanggalDanWaktu: entity.tanggalDanWaktu,
      jumlah: entity.jumlah,
      judul: entity.judul,
      deskripsi: entity.deskripsi,
      myUser: entity.myUser,
      tanggalDitambahkan: entity.tanggalDitambahkan,
    );
  }

  @override
  String toString() {
    return '''Jadwal: {
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
