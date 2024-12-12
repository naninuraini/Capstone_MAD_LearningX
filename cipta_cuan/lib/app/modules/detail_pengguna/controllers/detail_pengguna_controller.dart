import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailPenggunaController extends GetxController {
  String formatRupiah(num number, String symbol) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: symbol,
      decimalDigits: 0,
    );
    return formatter.format(number);
  }
}
