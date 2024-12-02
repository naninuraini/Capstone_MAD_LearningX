import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../widget/button.dart';
import '../../../../widget/constant.dart';
import '../../../../widget/text_field.dart';
import '../../../../widget/validators.dart';
import '../controllers/tambah_transaksi_controller.dart';

class TambahTransaksiView extends StatefulWidget {
  const TambahTransaksiView({super.key});
  @override
  State<TambahTransaksiView> createState() => _TambahTransaksiState();
}

class _TambahTransaksiState extends State<TambahTransaksiView> {
  final TambahTransaksiController controller =
      Get.find<TambahTransaksiController>();
  File? _selectedImage;

  Future _pickImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
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
                key: controller.formKeyTambahTransaksi,
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SecondTextFieldWidget(
                        hintText: 'Pilih Tanggal',
                        headerText: "Tanggal",
                        suffixIcon: "assets/icons/textfield_calender.svg",
                        onPressedSuffix: () {},
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
                      SecondTextFieldWidget(
                        hintText: 'Pilih Kategori',
                        headerText: "Kategori",
                        suffixIcon: "assets/icons/textfield_kategori.svg",
                        onPressedSuffix: () {},
                        controller: controller.kategoriController,
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
                            controller.formKeyTambahTransaksi.currentState!
                                .save();
                            setState(() {
                              // context
                              //     .read<CreatePostBloc>()
                              //     .add(CreatePost(post, _selectedImage!.path, context.read<AuthenticationBloc>().state.user!.uid));
                            });
                            // Navigator.pop(context);
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
