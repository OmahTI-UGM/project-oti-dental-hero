import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/common/outline_text.dart';
import 'package:dental_hero/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dental_hero/features/auth/presentation/blocs/auth/auth_event.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
    return AppBar(
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
                    "Pengaturan",
                    style: GoogleFonts.fredoka(
                        color: purpleColor,
                        fontSize: 21,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: shadeBlueColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: purpleColor,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.0),
                child: OutlineText(
                  color: Colors.white,
                  text: 'Bantuan',
                  size: 18,
                  fontWeight: FontWeight.w600,
                  outlineColor: purpleColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: shadeBlueColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: purpleColor,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.0),
                child: OutlineText(
                  color: Colors.white,
                  text: 'Tentang Kami',
                  size: 18,
                  fontWeight: FontWeight.w600,
                  outlineColor: purpleColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              BlocProvider.of<AuthBloc>(context).add(const LogoutEvent());

              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            },
            child: Container(
              decoration: BoxDecoration(
                color: redColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: purpleColor,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.0),
                child: OutlineText(
                  color: Colors.white,
                  text: 'Keluar dari Akun',
                  size: 18,
                  fontWeight: FontWeight.w600,
                  outlineColor: purpleColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
