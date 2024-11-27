import 'package:get/get.dart';

class CategoryController extends GetxController {
  // Daftar kategori
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
}
