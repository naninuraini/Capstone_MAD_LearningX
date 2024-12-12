import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/jadwal/jadwal_model.dart';
import '../../../../widget/button.dart';
import '../../../../widget/text_field.dart';
import '../../../../widget/validators.dart';
import '../controllers/tambah_jadwal_controller.dart';

class TambahJadwalView extends StatefulWidget {
  final MyUser? myUser;
  const TambahJadwalView({super.key, required this.myUser});
  @override
  State<TambahJadwalView> createState() => _TambahJadwalState();
}

class _TambahJadwalState extends State<TambahJadwalView> {
  final TambahJadwalController controller =
      Get.find<TambahJadwalController>();
  late Jadwal jadwal;

  @override
  void initState() {
    jadwal = Jadwal.empty;
    jadwal.myUser = widget.myUser!;
    super.initState();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2026),
    );
    if (pickedDate != null) {
      setState(() {
        controller.selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        controller.selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(Get.context!),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Tambah Jadwal",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF24325F),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: Form(
                key: controller.formKeyTambahJadwal,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SecondTextFieldWidget(
                        hintText: controller.selectedDateTime != null
                            ? DateFormat("d MMMM yyyy", "id_ID")
                                .format(controller.selectedDateTime!)
                            : 'Pilih Tanggal',
                        hintStyle: TextStyle(
                          color: controller.selectedDateTime != null
                              ? AppColors.black
                              : AppColors.textTF,
                        ),
                        readOnly: true,
                        headerText: "Tanggal",
                        suffixIcon: "assets/icons/textfield_calender.svg",
                        onPressedSuffix: () => _selectDateTime(context),
                        controller: controller.tanggalController,
                        keyboardType: TextInputType.datetime,
                        validator: (val) {
                          if (controller.selectedDateTime == null) {
                            return 'Tanggal tidak boleh kosong';
                          }
                          val = DateFormat("d MMMM yyyy", "id_ID")
                              .format(controller.selectedDateTime!);
                          if (!dateRegExp.hasMatch(val)) {
                            return 'tanggal tidak valid';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      SecondTextFieldWidget(
                        hintText: 'Masukkan Jumlah',
                        headerText: "Jumlah",
                        suffixIcon: "",
                        onPressedSuffix: () {},
                        controller: controller.jumlahController,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Jumlah tidak boleh kosong';
                          } else if (!numberRegExp.hasMatch(val)) {
                            return 'Jumlah tidak valid';
                          } else if (int.parse(val) < 1) {
                            return 'Jumlah harus di atas 1';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      SecondTextFieldWidget(
                        hintText: 'Masukkan Judul Transaksi',
                        headerText: "Judul",
                        suffixIcon: "",
                        onPressedSuffix: () {},
                        controller: controller.judulController,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Judul Tidak Boleh Kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      SecondTextFieldWidget(
                        hintText: 'Masukkan Deskripsi',
                        headerText: "Deskripsi",
                        suffixIcon: "",
                        onPressedSuffix: () {},
                        controller: controller.deskripsiController,
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Deskripsi Tidak Boleh Kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      SecondTextFieldWidget(
                        hintText: controller.selectedTime != null
                            ? controller.selectedTime!.format(context)
                            : 'Atur Waktu',
                        hintStyle: TextStyle(
                          color: controller.selectedTime != null
                              ? AppColors.black
                              : AppColors.textTF,
                        ),
                        readOnly: true,
                        headerText: "Waktu", 
                        suffixIcon: "clock",
                        onPressedSuffix: () => _selectTime(context),
                        controller: controller.waktuController,
                        keyboardType: TextInputType.datetime,
                        validator: (val) {
                          if (controller.selectedTime == null) {
                            return 'Waktu tidak boleh kosong';
                          }
                          val = controller.selectedTime!.format(context);
                          if (!timeRegExp24Hour.hasMatch(val)) {
                            return 'Waktu tidak valid';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      ButtonWidget(
                        // textSize: 15.0,
                        title: 'Upload',
                        onPressed: () {
                          if (controller
                              .formKeyTambahJadwal.currentState!
                              .validate()) {
                            setState(() {
                              jadwal.tanggalDanWaktu = controller.selectedDateTime!;
                              jadwal.jumlah = int.parse(
                                  controller.jumlahController.text);
                              jadwal.judul = controller.judulController.text;
                              jadwal.deskripsi =
                                  controller.deskripsiController.text;
                            });
                            controller.addData(jadwal);
                          }
                        },
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
