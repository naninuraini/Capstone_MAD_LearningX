import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime? selectedDate;
  DateTime currentMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final daysInMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    final firstDayWeekday = firstDayOfMonth.weekday;
    final emptyDays = firstDayWeekday % 7;
    final List<int?> dates = List.generate(
      emptyDays,
      (_) => null,
    )..addAll(
        List.generate(daysInMonth, (index) => index + 1),
      );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: DateFormat('MMMM').format(currentMonth),
                items: List.generate(
                  12,
                  (index) {
                    final month = DateTime(0, index + 1);
                    return DropdownMenuItem(
                      value: DateFormat('MMMM').format(month),
                      child: Text(
                        DateFormat('MMMM').format(month),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
                dropdownColor: const Color(0xFF24325F),
                onChanged: (newMonth) {
                  if (newMonth != null) {
                    final monthIndex = DateFormat('MMMM').parse(newMonth).month;
                    setState(
                      () {
                        currentMonth = DateTime(
                          currentMonth.year,
                          monthIndex,
                          1,
                        );
                        selectedDate = null;
                      },
                    );
                  }
                },
              ),
              DropdownButton<int>(
                value: currentMonth.year,
                items: List.generate(
                  20,
                  (index) {
                    final year = DateTime.now().year - 10 + index;
                    return DropdownMenuItem(
                      value: year,
                      child: Text(
                        '$year',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
                dropdownColor: const Color(0xFF24325F),
                onChanged: (newYear) {
                  if (newYear != null) {
                    setState(
                      () {
                        currentMonth = DateTime(
                          newYear,
                          currentMonth.month,
                          1,
                        );
                        selectedDate = null;
                      },
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Min", style: TextStyle(color: Colors.white)),
              Text("Sen", style: TextStyle(color: Colors.white)),
              Text("Sel", style: TextStyle(color: Colors.white)),
              Text("Rab", style: TextStyle(color: Colors.white)),
              Text("Kam", style: TextStyle(color: Colors.white)),
              Text("Jum", style: TextStyle(color: Colors.white)),
              Text("Sab", style: TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dates.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              final date = dates[index];
              final today =
                  DateTime.now().toLocal(); // Tanggal saat ini sesuai WIB
              final isToday = date != null &&
                  date == today.day &&
                  currentMonth.month == today.month &&
                  currentMonth.year == today.year;

              final isSelected = date != null &&
                  selectedDate != null &&
                  date == selectedDate!.day &&
                  currentMonth.month == selectedDate!.month &&
                  currentMonth.year == selectedDate!.year;

              return date == null
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            if (isSelected) {
                              selectedDate = null;
                            } else {
                              selectedDate = DateTime(
                                currentMonth.year,
                                currentMonth.month,
                                date,
                              );
                            }
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isToday
                              ? const Color(0xFF00D7FF)
                              : isSelected
                                  ? Colors.grey
                                  : Colors.grey,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(
                                  color: const Color(0xFF429BED),
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Text(
                          '$date',
                          style: TextStyle(
                            color: isToday || isSelected
                                ? Colors.white
                                : Colors.black,
                            fontWeight: isToday || isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
