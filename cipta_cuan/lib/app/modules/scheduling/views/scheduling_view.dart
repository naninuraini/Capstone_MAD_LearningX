import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/scheduling_controller.dart';

class SchedulingView extends GetView<SchedulingController> {
  const SchedulingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Penjadwalan",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          CalendarWidget(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF24325F),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(30),
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final daysInMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
    final firstDayWeekday = firstDayOfMonth.weekday; // 1 = Senin, 7 = Minggu

    // Membuat daftar tanggal dengan mengisi kekosongan sebelum tanggal pertama
    final List<int?> dates = List.generate(
      firstDayWeekday - 1,
      (_) => null, // Tempat kosong sebelum tanggal pertama
    )..addAll(
        List.generate(daysInMonth, (index) => index + 1)); // Tanggal bulan

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: DateFormat('MMMM').format(selectedDate),
                items: List.generate(12, (index) {
                  final month = DateTime(0, index + 1);
                  return DropdownMenuItem(
                    value: DateFormat('MMMM').format(month),
                    child: Text(
                      DateFormat('MMMM').format(month),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }),
                dropdownColor: const Color(0xFF24325F),
                onChanged: (newMonth) {
                  if (newMonth != null) {
                    final monthIndex =
                        DateFormat('MMMM').parse(newMonth!).month;
                    setState(
                      () {
                        selectedDate = DateTime(
                          selectedDate.year,
                          monthIndex,
                          selectedDate.day,
                        );
                      },
                    );
                  }
                },
              ),
              const SizedBox(width: 20),
              DropdownButton<int>(
                value: selectedDate.year,
                items: List.generate(20, (index) {
                  final year = DateTime.now().year - 10 + index;
                  return DropdownMenuItem(
                    value: year,
                    child: Text(
                      '$year',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }),
                dropdownColor: const Color(0xFF24325F),
                onChanged: (newYear) {
                  if (newYear != null) {
                    setState(
                      () {
                        selectedDate = DateTime(
                          newYear ?? selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Sen", style: TextStyle(color: Colors.white)),
            Text("Sel", style: TextStyle(color: Colors.white)),
            Text("Rab", style: TextStyle(color: Colors.white)),
            Text("Kam", style: TextStyle(color: Colors.white)),
            Text("Jum", style: TextStyle(color: Colors.white)),
            Text("Sab", style: TextStyle(color: Colors.white)),
            Text("Min", style: TextStyle(color: Colors.white)),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  DateTime(selectedDate.year, selectedDate.month + 1, 0).day,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                final date = index + 1;
                final isSelected = date == selectedDate.day;

                return GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        selectedDate = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          date,
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF0DA6C2) : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$date',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
