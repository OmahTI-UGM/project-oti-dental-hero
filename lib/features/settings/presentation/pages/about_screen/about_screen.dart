import 'dart:ui';

import 'package:dental_hero/core/common/color.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: lightBlueColor,
      appBar: _buildAppbar(height, width, context),
      body: _buildBody(context),
    );
  }

  _buildAppbar(double height, double width, BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height * 0.1),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: lightBlueColor,
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Tentang Kami",
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

  _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: purpleColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logos.png'),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Dental Hero',
                  style: GoogleFonts.fredoka(
                    color: purpleColor,
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Aplikasi DENTAL HERO merupakan salah satu media edukasi Dental Hero Game Kit inovasi Tim PKM-PM Dental Hero, Universitas Gadjah Mada. Aplikasi Dental Hero dikemas dalam bentuk tantangan tiga puluh hari menyikat gigi sebagai upaya meningkatkan kesadaran menjaga kesehatan gigi dan mulut.\n\nSayangi Gigi, Senyum Berseri, Dental Hero Beraksi!!\n#FromZeroToHero #YourSmileGuardians.',
                style: GoogleFonts.fredoka(
                  color: purpleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 12),
              Image.asset('assets/images/team.png'),
            ],
          ),
        ),
      ),
    );
  }
}
