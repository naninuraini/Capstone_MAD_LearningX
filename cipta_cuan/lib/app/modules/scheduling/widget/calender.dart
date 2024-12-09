import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  final Function(DateTime) onDateSelected;

  const CalendarWidget({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "Pilih Tanggal",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                onDateSelected(pickedDate);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Klik untuk memilih tanggal",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../controllers/scheduling_controller.dart';

// class CalendarWidget extends StatefulWidget {
//   const CalendarWidget({super.key});

//   @override
//   _CalendarWidgetState createState() => _CalendarWidgetState();
// }

// class _CalendarWidgetState extends State<CalendarWidget> {
//   final SchedulingController controller = Get.put(SchedulingController());

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               DropdownButton<String>(
//                 value: DateFormat('MMMM').format(controller.currentMonth),
//                 items: List.generate(
//                   12,
//                   (index) {
//                     final month = DateTime(0, index + 1);
//                     return DropdownMenuItem(
//                       value: DateFormat('MMMM').format(month),
//                       child: Text(
//                         DateFormat('MMMM').format(month),
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     );
//                   },
//                 ),
//                 dropdownColor: const Color(0xFF24325F),
//                 onChanged: (newMonth) {
//                   if (newMonth != null) {
//                     final monthIndex = DateFormat('MMMM').parse(newMonth).month;
//                     setState(
//                       () {
//                         controller.currentMonth = DateTime(
//                           controller.currentMonth.year,
//                           monthIndex,
//                           1,
//                         );
//                         controller.selectedDate = null;
//                       },
//                     );
//                   }
//                 },
//               ),
//               DropdownButton<int>(
//                 value: controller.currentMonth.year,
//                 items: List.generate(
//                   20,
//                   (index) {
//                     final year = DateTime.now().year - 10 + index;
//                     return DropdownMenuItem(
//                       value: year,
//                       child: Text(
//                         '$year',
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     );
//                   },
//                 ),
//                 dropdownColor: const Color(0xFF24325F),
//                 onChanged: (newYear) {
//                   if (newYear != null) {
//                     setState(
//                       () {
//                         controller.currentMonth = DateTime(
//                           newYear,
//                           controller.currentMonth.month,
//                           1,
//                         );
//                         controller.selectedDate = null;
//                       },
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: const [
//               Text("Min", style: TextStyle(color: Colors.white)),
//               Text("Sen", style: TextStyle(color: Colors.white)),
//               Text("Sel", style: TextStyle(color: Colors.white)),
//               Text("Rab", style: TextStyle(color: Colors.white)),
//               Text("Kam", style: TextStyle(color: Colors.white)),
//               Text("Jum", style: TextStyle(color: Colors.white)),
//               Text("Sab", style: TextStyle(color: Colors.white)),
//             ],
//           ),
//           const SizedBox(height: 10),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: controller.dates.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 7,
//               crossAxisSpacing: 5,
//               mainAxisSpacing: 5,
//             ),
//             itemBuilder: (context, index) {
//               final date = controller.dates[index];
//               final today =
//                   DateTime.now().toLocal(); // Tanggal saat ini sesuai WIB
//               final isToday = date != null &&
//                   date == today.day &&
//                   controller.currentMonth.month == today.month &&
//                   controller.currentMonth.year == today.year;

//               final isSelected = date != null &&
//                   controller.selectedDate != null &&
//                   date == controller.selectedDate!.day &&
//                   controller.currentMonth.month == controller.selectedDate!.month &&
//                   controller.currentMonth.year == controller.selectedDate!.year;

//               return date == null
//                   ? Container()
//                   : GestureDetector(
//                       onTap: () {
//                         setState(
//                           () {
//                             if (isSelected) {
//                               controller.selectedDate = null;
//                             } else {
//                               controller.selectedDate = DateTime(
//                                 controller.currentMonth.year,
//                                 controller.currentMonth.month,
//                                 date,
//                               );
//                             }
//                           },
//                         );
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: isToday
//                               ? const Color(0xFF00D7FF)
//                               : isSelected
//                                   ? Colors.grey
//                                   : Colors.grey,
//                           shape: BoxShape.circle,
//                           border: isSelected
//                               ? Border.all(
//                                   color: const Color(0xFF429BED),
//                                   width: 2,
//                                 )
//                               : null,
//                         ),
//                         child: Text(
//                           '$date',
//                           style: TextStyle(
//                             color: isToday || isSelected
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontWeight: isToday || isSelected
//                                 ? FontWeight.bold
//                                 : FontWeight.normal,
//                           ),
//                         ),
//                       ),
//                     );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
