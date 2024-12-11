import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SchedulingController extends GetxController {
  final selectedDate = DateTime.now().obs;

  List<int?> getDatesInMonth() {
    final firstDayOfMonth = DateTime(selectedDate.value.year, selectedDate.value.month, 1);
    final daysInMonth = DateTime(selectedDate.value.year, selectedDate.value.month + 1, 0).day;
    final firstDayWeekday = firstDayOfMonth.weekday;

    return List.generate(
      firstDayWeekday == 7 ? 0 : firstDayWeekday, 
      (_) => null,
    )..addAll(
        List.generate(daysInMonth, (index) => index + 1),
      );
  }

  void changeMonth(String newMonth) {
    final monthIndex = DateFormat('MMMM').parse(newMonth).month;
    selectedDate.value = DateTime(selectedDate.value.year, monthIndex, selectedDate.value.day);
  }

  void changeYear(int newYear) {
    selectedDate.value = DateTime(newYear, selectedDate.value.month, selectedDate.value.day);
  }

  void selectDate(int date) {
    selectedDate.value = DateTime(selectedDate.value.year, selectedDate.value.month, date);
  }
}
