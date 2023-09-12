import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/widgets/button.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoGuideScreen extends StatelessWidget {
  const PhotoGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: lightBlueColor,
      appBar: _buildAppbar(height, width),
      body: _buildBody(height, width, context),
    );
  }

  _buildAppbar(double height, double width) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height * 0.1),
      child: AppBar(
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
              children: [
                Text(
                  'Foto Gigi',
                  style: GoogleFonts.fredoka(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: purpleColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Dalam mengambil foto rongga mulut, teman-teman perlu memperhatikan beberapa hal:',
                  style: GoogleFonts.fredoka(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: purpleColor),
                ),
                Text(
                  '\u2022 Kondisi pencahayaan ruangan yang cukup\n\u2022 Handphone dengan kamera yang memadai\n\u2022 Bantuan dari orang sekitar',
                  style: GoogleFonts.fredoka(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: purpleColor),
                ),
                Text(
                  '\nSetelah semua dipersiapkan, teman-teman dapat mulai foto dengan mengikuti panduan yang akan ditampilkan!',
                  style: GoogleFonts.fredoka(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: purpleColor),
                ),
                const SizedBox(height: 12),
                Button(
                    text: 'Mulai Foto',
                    width: double.infinity,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/photo-steps', (route) => false);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
