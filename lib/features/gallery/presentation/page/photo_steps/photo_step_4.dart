import 'dart:io';

import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/widgets/button.dart';
import 'package:dental_hero/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dental_hero/features/gallery/presentation/blocs/image_picker/image_picker_bloc.dart';
import 'package:dental_hero/features/gallery/presentation/widget/bullet_list.dart';
import 'package:dental_hero/features/gallery/presentation/widget/photo_box.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_bloc.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_events.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/image_picker/image_picker_event.dart';
import '../../blocs/image_picker/image_picker_state.dart';

class PhotoStep4Screen extends StatelessWidget {
  const PhotoStep4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ImagePickerBloc>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: lightBlueColor,
        appBar: _buildAppbar(height, width),
        body: BlocListener<ImagePickerBloc, ImagePickerState>(
          listener: (context, state) {
            if (state is SuccessImagePickerState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Foto berhasil diunggah!'),
                ),
              );

              // reload home data
              BlocProvider.of<HomeBloc>(context).add(LoadDataEvent(
                  userId: BlocProvider.of<AuthBloc>(context).state.user!.id!));

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (route) => false);
            }

            if (state is FailedImagePickerState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Foto gagal diunggah!'),
                ),
              );
            }
          },
          child: _buildBody(height, width, context),
        ));
  }

  _buildAppbar(double height, double width) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height * 0.1),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffE9F3FF),
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff6A658A), width: 1.0),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.40),
                    offset: const Offset(4, -4),
                    blurRadius: 0,
                    spreadRadius: 0,
                    inset: true,
                  ),
                ],
              ),
              width: double.infinity,
              height: height * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'assets/images/icon_back.png',
                      ),
                      iconSize: 36,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Foto Gigi",
                      style: GoogleFonts.fredoka(
                          color: purpleColor,
                          fontSize: 21,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  _buildBody(double height, double width, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: purpleColor, width: 1.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Langkah 4/4',
                        style: GoogleFonts.fredoka(
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                            color: purpleColor),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Foto Permukaan Kunyah Gigi Atas',
                        style: GoogleFonts.fredoka(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: purpleColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                BlocBuilder<ImagePickerBloc, ImagePickerState>(
                  builder: (context, state) {
                    if (state is LoadingImagePickerState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is ImagePickedState) {
                      final image = state.image;

                      // Process the selected image (e.g., display it or upload it)
                      // You can use the 'image' variable to access the selected image file
                      // For example, you can display it in an Image widget.
                      // You may also need to save or upload the image as needed by your application.

                      return Column(
                        children: [
                          Text(
                            'Ini hasil foto yang kamu ambil. Sebelum melanjutkan ke langkah selanjutnya, pastikan sudah sesuai dengan contoh panduan ya!',
                            style: GoogleFonts.fredoka(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: purpleColor),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          const PhotoBox(
                            image: 'assets/images/photo_step_4.png',
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(image.path),
                              height: MediaQuery.of(context).size.height * 0.27,
                              width: MediaQuery.of(context).size.width * 0.8,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Button(
                                  blue: false,
                                  text: 'Ulangi',
                                  width: double.infinity,
                                  onTap: () {
                                    BlocProvider.of<ImagePickerBloc>(context)
                                        .add(DeleteImageEvent());
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Button(
                                  text: 'Selesai',
                                  width: double.infinity,
                                  onTap: () {
                                    BlocProvider.of<ImagePickerBloc>(context)
                                        .add(SubmitImageEvent());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ); // Display the selected image
                    } else {
                      return Column(
                        children: [
                          Text(
                            'Saatnya mengambil foto! Yuk ikuti panduan foto berikut:',
                            style: GoogleFonts.fredoka(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: purpleColor),
                          ),
                          BulletList(
                            const [
                              'Buka mulut dengan lebar dan tengadahkan kepala.',
                              'Arahkan kamera ke permukaan kunyah gigi atas.',
                              'Gunakan flash untuk pencahayaan yang lebih baik',
                            ],
                          ),
                          const SizedBox(height: 12),
                          const PhotoBox(
                            image: 'assets/images/photo_step_4.png',
                          ),
                          const SizedBox(height: 12),
                          Button(
                            text: 'Ambil Foto Langkah 3',
                            width: double.infinity,
                            onTap: () {
                              BlocProvider.of<ImagePickerBloc>(context)
                                  .add(PickImageEvent());
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
