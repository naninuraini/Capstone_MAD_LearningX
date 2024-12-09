import 'package:cipta_cuan/app/modules/scheduling/widget/card_jadwal.dart';
import 'package:cipta_cuan/models/jadwal/jadwal_model.dart';
import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:cipta_cuan/app/modules/scheduling/widget/calender.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../tambah_jadwal/bindings/tambah_jadwal_binding.dart';
import '../../tambah_jadwal/views/tambah_jadwal_view.dart';
import '../controllers/scheduling_controller.dart';

class SchedulingView extends StatefulWidget {
  final MyUser? myUser;
  const SchedulingView({super.key, required this.myUser});

  @override
  _SchedulingViewState createState() => _SchedulingViewState();
}

class _SchedulingViewState extends State<SchedulingView> {
  final SchedulingController controller = Get.put(SchedulingController());
  DateTime? selectedDate;

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
      floatingActionButton: Material(
        elevation: 10.0,
        shape: CircleBorder(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0DA6C2),
                Color(0xFF0E39C6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: FloatingActionButton(
            onPressed: () {
              Get.to(
                () => TambahJadwalView(myUser: widget.myUser),
                binding: TambahJadwalBinding(),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            backgroundColor: Colors.transparent,
            splashColor: Colors.transparent,
            elevation: 0.0,
            focusElevation: 0.0,
            highlightElevation: 0.0,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          CalendarWidget(
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
              controller.fetchJadwalByDate(date);
            },
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF24325F),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: Obx(() {
                final jadwalList = controller.jadwalList;

                if (jadwalList.isEmpty) {
                  return Center(
                    child: Text(
                      "Tidak ada jadwal untuk tanggal ini.",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.all(30),
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Jadwal Tagihan",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Color(0xFFE1E1E1),
                              borderRadius: BorderRadius.circular(20)),
                          child: IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset("assets/icons/trash.svg")),
                        ),
                        ListView.builder(itemBuilder: (context, index) {
                          return CardJadwal(
                          jadwal: jadwalList[index] as Jadwal,
                          selectedDate: selectedDate,
                        );
                        })
                        
                      ],
                    )
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
