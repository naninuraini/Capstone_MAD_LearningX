import 'dart:io';

import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../models/post/post_model.dart';
import '../../../../widget/button.dart';
import '../../../../widget/text_field.dart';
import '../controllers/tambah_transaksi_controller.dart';

class TambahTransaksiView extends StatefulWidget {
  final MyUser? myUser;
  const TambahTransaksiView({super.key, required this.myUser});
  @override
  State<TambahTransaksiView> createState() => _TambahTransaksiState();
}

class _TambahTransaksiState extends State<TambahTransaksiView> {
  final TambahTransaksiController controller =
      Get.find<TambahTransaksiController>();
  File? _selectedImage;
  late Post post;

  @override
  void initState() {
    post = Post.empty;
    post.myUser = widget.myUser!;
    super.initState();
  }

  Future _pickImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        controller.selectedDateTime = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Tambah Transaksi",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
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
                    key: controller.formKeyTambahTransaksi,
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
                              // if (val!.isEmpty) {
                              //   return 'Nama Tidak Boleh Kosong';
                              // } else if (val.length > 30) {
                              //   return 'Nama Terlalu Panjang';
                              // }
                              // return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Obx(
                            () => 
                            // Stack(
                            //   children: [
                                SecondTextFieldWidget(
                                  hintText:
                                      controller.selectedItem.value.isNotEmpty
                                          ? controller.selectedItem.value
                                          : 'Pilih Kategori',
                                  headerText: "Kategori",
                                  suffixIcon:
                                      "assets/icons/textfield_kategori.svg",
                                  onPressedSuffix: controller.toggleDropdown,
                                  readOnly: true,
                                  controller: controller.kategoriController,
                                  keyboardType: TextInputType.text,
                                  validator: (val) {
                                    // Validator
                                  },
                                ),
                                // if (controller.isDropdownVisible.value)
                                //   Positioned(
                                //     left: 0,
                                //     right: 0,
                                //     top: 60, // Sesuaikan posisi dropdown
                                //     child: Material(
                                //       elevation: 4,
                                //       child: Container(
                                //         color: Colors.white,
                                //         child: Column(
                                //           mainAxisSize: MainAxisSize.min,
                                //           children: controller.dropdownItems
                                //               .map(
                                //                 (item) => ListTile(
                                //                   title: Text(item),
                                //                   onTap: () {
                                //                     controller.selectItem(item);
                                //                     controller.kategoriController
                                //                         .text = item;
                                //                     controller
                                //                         .toggleDropdown(); // Tutup dropdown
                                //                   },
                                //                 ),
                                //               )
                                //               .toList(),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                            //   ],
                            // ),
                          ),
                          // Obx(
                          //   () => Column(
                          //     children: [
                          //       Stack(
                          //         children: [
                          //           SecondTextFieldWidget(
                          //             hintText:
                          //                 controller.selectedItem.value != ""
                          //                     ? controller.selectedItem.value
                          //                     : 'Pilih Kategori',
                          //             headerText: "Kategori",
                          //             suffixIcon:
                          //                 "assets/icons/textfield_kategori.svg",
                          //             onPressedSuffix: controller.toggleDropdown,
                          //             readOnly: true,
                          //             controller: controller.kategoriController,
                          //             keyboardType: TextInputType.text,
                          //             validator: (val) {
                          //               // if (val!.isEmpty) {
                          //               //   return 'Nama Tidak Boleh Kosong';
                          //               // } else if (val.length > 30) {
                          //               //   return 'Nama Terlalu Panjang';
                          //               // }
                          //               // return null;
                          //             },
                          //           ),
                          //           if (controller.isDropdownVisible.value)
                          //             Positioned(
                          //               left: 0,
                          //               right: 0,
                          //               top: 60,
                          //               child: Card(
                          //                 elevation: 4,
                          //                 child: Column(
                          //                   children: controller.dropdownItems
                          //                       .map(
                          //                         (item) => ListTile(
                          //                           title: Text(item),
                          //                           onTap: () {
                          //                             controller.selectItem(item);
                          //                             controller.kategoriController
                          //                                 .text = item;
                          //                           },
                          //                         ),
                          //                       )
                          //                       .toList(),
                          //                 ),
                          //               ),
                          //             ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(height: 20),
                          SecondTextFieldWidget(
                            hintText: 'Masukkan Jumlah',
                            headerText: "Jumlah",
                            suffixIcon: "",
                            onPressedSuffix: () {},
                            controller: controller.jumlahController,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              // if (val!.isEmpty) {
                              //   return 'Nama Tidak Boleh Kosong';
                              // } else if (val.length > 30) {
                              //   return 'Nama Terlalu Panjang';
                              // }
                              // return null;
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
                              // if (val!.isEmpty) {
                              //   return 'Nama Tidak Boleh Kosong';
                              // } else if (val.length > 30) {
                              //   return 'Nama Terlalu Panjang';
                              // }
                              // return null;
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
                              // if (val!.isEmpty) {
                              //   return 'Nama Tidak Boleh Kosong';
                              // } else if (val.length > 30) {
                              //   return 'Nama Terlalu Panjang';
                              // }
                              // return null;
                            },
                          ),
                          SizedBox(height: 20),
                          GetBuilder<TambahTransaksiController>(
                            builder: (controller) {
                              if (_selectedImage == null) {
                                return ImageTextFieldWidget(
                                  headerText: "Gambar",
                                  onTapField: () {
                                    _pickImage();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Foto Dulu';
                                    }
                                    return null;
                                  },
                                );
                              } else {
                                return Center(
                                  child: Container(
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      // border: Border.all(
                                      // color: AppColors.kpo, width: 5.0),
                                      boxShadow: [
                                        BoxShadow(
                                          // color: Colors.red.shade400,
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.file(
                                        _selectedImage!,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 30),
                          ButtonWidget(
                            // textSize: 15.0,
                            title: 'Upload',
                            onPressed: () {
                              if (controller
                                  .formKeyTambahTransaksi.currentState!
                                  .validate()) {
                                setState(() {
                                  post.tanggal = controller.selectedDateTime!;
                                  post.kategori =
                                      controller.kategoriController.text;
                                  post.jumlah = int.parse(
                                      controller.jumlahController.text);
                                  post.judul = controller.judulController.text;
                                  post.deskripsi =
                                      controller.deskripsiController.text;
                                });
                                controller.addData(post, _selectedImage!.path);
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
          if (controller.isDropdownVisible.value)
            Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height / 4 + 24,
              child: Material(
                elevation: 4,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: controller.dropdownItems
                        .map(
                          (item) => ListTile(
                            title: Text(item),
                            onTap: () {
                              controller.selectItem(item);
                              controller.kategoriController.text = item;
                              controller.toggleDropdown();
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
