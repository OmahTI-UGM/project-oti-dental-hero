import 'dart:ui';

import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/features/augmented_reality/presentation/widget/instruction_card.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

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
                      "Panduan Kartu 3D",
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            InstructionCard(
              index: 1,
              text:
                  'Arahkan Kamera ke Kartu. Posisikan kamera ponsel Anda sehingga QR code berada di dalam bingkai putih yang tampak pada kamera. Aplikasi akan secara otomatis mencoba membaca kode QR begitu terdeteksi.',
              image: 'assets/images/step1.png',
            ),
            const SizedBox(height: 10),
            InstructionCard(
              index: 2,
              text:
                  'Setelah QR code terdeteksi, Anda akan melihat panduan animasi yang mirip dengan yang ditampilkan dalam gambar di sebelah ini. Selanjutnya, carilah permukaan datar di sekitar Anda, seperti meja atau lantai, dan arahkan kamera Anda ke sana untuk memindai. Hindari permukaan yang reflektif.',
              image: 'assets/images/step2.png',
            ),
            const SizedBox(height: 10),
            InstructionCard(
              index: 3,
              text:
                  'Gerakkan kamera Anda secara perlahan ke sebelah atas, kanan, kiri, atau bawah sekitar bidang tersebut. Terus lakukan ini sampai gambar panduan di tengah hilang seperti pada video di sebelah. Ini penting untuk memungkinkan aplikasi mengenali permukaan datar dengan baik dan menampilkan model AR. ',
              image: 'assets/images/step3.gif',
            ),
            const SizedBox(height: 10),
            InstructionCard(
              index: 4,
              text:
                  'Tunggu beberapa saat, dan Anda akan melihat lingkaran-lingkaran muncul di atas permukaan yang telah Anda pindai, seperti yang ditunjukkan dalam gambar di sebelah kiri. Setelah itu, cukup SENTUH SEKALI pada area yang diberi lingkaran-lingkaran tersebut untuk menunjuk di mana Model AR akan ditampilkan. ',
              image: 'assets/images/step4.png',
            ),
            const SizedBox(height: 10),
            InstructionCard(
              index: 5,
              text:
                  'Selanjutnya, harap bersabar sejenak karena aplikasi akan mengambil waktu untuk memuat model AR. Anda akan melihat tanda berupa lingkaran biru di tengah yang menandakan proses ini.',
              image: 'assets/images/step5.png',
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.46,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: purpleColor, width: 1.0),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 14.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '6.',
                          style: GoogleFonts.fredoka(
                            color: purpleColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Expanded(
                            child: Text(
                              'Setelah beberapa saat, model AR gigi menyikat akan muncul di layar. Anda bisa langsung berinteraksi dengannya. Untuk melihatnya dengan lebih jelas atau lebih besar, cukup maju dan arahkan kamera Anda lebih dekat ke bidang tersebut.',
                              style: GoogleFonts.fredoka(
                                color: purpleColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Image.asset(
                      'assets/images/step6.png',
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
