import 'dart:io';

import 'package:cipta_cuan/app/modules/edit_transaksi/controllers/edit_transaksi_controller.dart';
import 'package:cipta_cuan/models/post/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widget/button.dart';
import '../../../../widget/text_field.dart';

class EditTransaksiView extends StatefulWidget {
  final Post post;
  EditTransaksiView({Key? key, required this.post}) : super(key: key);

  @override
  State<EditTransaksiView> createState() => _EditTransaksiState();
}

class _EditTransaksiState extends State<EditTransaksiView> {
  final EditTransaksiController controller = Get.put(EditTransaksiController());
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    controller.initialize(widget.post);
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.post.tanggal,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        controller.selectedDateTime = pickedDate;
        controller.tanggalController.text = DateFormat("d MMMM yyyy", "id_ID").format(pickedDate);
      });
    }
  }

  void _deletePost(Post post) {
    controller.deletePost(post);
    Get.snackbar('Success', 'Transaksi deleted successfully');
    Navigator.pop(Get.context!);
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
        title: Text(
          "Edit ${widget.post.judul}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.white, // White color for the trash icon
            ),
            onPressed: () {
              _deletePost(widget.post); // Call the delete function
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF24325F),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                  child: Form(
                    key: controller.formKeyEditTransaksi,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
                      child: ListView(
                        children: [
                          SecondTextFieldWidget(
                            hintText: controller.selectedDateTime != null
                                ? DateFormat("d MMMM yyyy", "id_ID").format(controller.selectedDateTime!)
                                : 'Pilih Tanggal',
                            hintStyle: TextStyle(
                              color: controller.selectedDateTime != null ? Colors.black : Colors.grey,
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
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          SecondTextFieldWidget(
                            hintText: 'Masukkan Judul Transaksi',
                            headerText: "Judul",
                            onPressedSuffix: () {},
                            suffixIcon: "",
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
                            onPressedSuffix: () {},
                            suffixIcon: "",
                            hintText: 'Masukkan Deskripsi',
                            headerText: "Deskripsi",
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
                          SizedBox(height: 30),
                          ButtonWidget(
                            title: 'Simpan Perubahan',
                            onPressed: () {
                              if (controller.formKeyEditTransaksi.currentState!.validate()) {
                                controller.deletePost(widget.post);
                                widget.post.tanggal = controller.selectedDateTime!;
                                widget.post.judul = controller.judulController.text;
                                widget.post.deskripsi = controller.deskripsiController.text;
                                controller.updatePost(widget.post, _selectedImage?.path ?? '');
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
        ],
      ),
    );
  }
}