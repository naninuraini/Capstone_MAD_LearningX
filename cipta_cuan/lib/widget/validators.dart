RegExp emailRexExp = RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$');

RegExp passRexExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$');

RegExp specialCharRexExp =
    RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])');

RegExp dateRegExp = RegExp(
    r'^([1-9]|[12]\d|3[01]) (Januari|Februari|Maret|April|Mei|Juni|Juli|Agustus|September|Oktober|November|Desember) \d{4}$');

RegExp kategoriRegExp = RegExp(
    r'^(Konsumsi|Transportasi|Obat-Obatan|Bahan Makanan|Sewa|Hadiah|Tabungan|Hiburan|Lainnya)$');

RegExp numberRegExp = RegExp(r'^\d+$');