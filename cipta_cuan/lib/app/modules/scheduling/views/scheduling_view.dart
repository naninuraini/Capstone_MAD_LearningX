import 'package:cipta_cuan/widget/calender.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/scheduling_controller.dart';

class SchedulingView extends StatelessWidget {
  const SchedulingView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SchedulingController());

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
            onPressed: () {},
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
          const CalendarWidget(),
          const SizedBox(height: 30), 
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
                children: const [
                  // isi container
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
