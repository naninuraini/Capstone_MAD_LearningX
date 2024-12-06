import 'package:cipta_cuan/models/post/post_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailTransaksiController extends GetxController {
  late Post post; // Mendeklarasikan post yang akan diterima

  @override
  void onInit() {
    super.onInit();
    // Menangani data post yang diterima melalui Get.arguments
    post = Get.arguments['post']; // Menerima post dari halaman sebelumnya
  }

  String get formattedAmount {
    return post.kategori == 'pemasukan'
        ? "+ " + NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(post.jumlah)
        : "- " + NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(post.jumlah);
  }

  String get formattedDate {
    return DateFormat("MMM d, yyyy", "id_ID").format(post.tanggal);
  }
}
