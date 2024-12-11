import 'package:cipta_cuan/models/post/post_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailTransaksiController extends GetxController {
  late Post post;

  final List<Map<String, String>> categories = [
    {"icon": "assets/category/konsumsi.png", "label": "Konsumsi"},
    {"icon": "assets/category/transportasi.png", "label": "Transportasi"},
    {"icon": "assets/category/obat.png", "label": "Obat-Obatan"},
    {"icon": "assets/category/makanan.png", "label": "Bahan Makanan"},
    {"icon": "assets/category/sewa.png", "label": "Sewa"},
    {"icon": "assets/category/hadiah.png", "label": "Hadiah"},
    {"icon": "assets/category/tabungan.png", "label": "Tabungan"},
    {"icon": "assets/category/hiburan.png", "label": "Hiburan"},
    {"icon": "assets/category/lainnya.png", "label": "Lainnya"},
  ];

  @override
  void onInit() {
    super.onInit();
    post = Get.arguments['post']; 
  }

  String get formattedAmount {
    return post.kategori == 'Tabungan'
        ? "+ " + NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(post.jumlah)
        : "- " + NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(post.jumlah);
  }

  String get formattedDate {
    return DateFormat("MMM d, yyyy", "id_ID").format(post.tanggal);
  }
}
