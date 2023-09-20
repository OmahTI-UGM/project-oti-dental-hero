import 'package:confetti/confetti.dart';
import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/common/outline_text.dart';
import 'package:dental_hero/core/widgets/button.dart';
import 'package:dental_hero/core/widgets/star.dart';
import 'package:dental_hero/features/activity/presentation/blocs/confetti/confetti_bloc.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  final int? duration;
  ResultScreen({super.key, this.duration});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Future.delayed(const Duration(milliseconds: 100), () {
      context.read<ConfettiCubit>().activateConfetti();
    });

    return Scaffold(
      backgroundColor: const Color(0xffE9F3FF),
      body: _buildBody(height, width, context),
    );
  }

  _buildBody(double height, double width, BuildContext context) {
    return BlocBuilder<ConfettiCubit, ConfettiState>(
      builder: (context, state) {
        if (state == ConfettiState.active) {
          _confettiController.play();
          return Stack(
            children: [
              Center(
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection:
                      -3.14 / 2, // Change this value to adjust the direction
                  emissionFrequency:
                      0.05, // Increase this value for more confetti
                  numberOfParticles:
                      50, // Adjust the number of confetti particles
                  gravity: 0.07, // Add gravity to the confetti
                  maxBlastForce: 40,
                  shouldLoop: false,
                  colors: const [
                    Color(0xffFF6685),
                    Color(0xffFF66C2),
                    Color(0xff66B8FF),
                    Color(0xff8C66FF),
                    Color(0xffB366FF),
                    Color(0xffFF8C66),
                    Color(0xffEDFF66),
                    Color(0xff66FFAB),
                  ],
                ),
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  height: height * 0.55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: purpleColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Keren! Kamu Sudah Selesai Menyikat Gigi',
                        style: GoogleFonts.fredoka(
                          color: purpleColor,
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: height * 0.27,
                        width: width * 0.54,
                        child: Stack(children: [
                          Image.asset('assets/images/score_happy.png'),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: StarWidget(
                              star: _countScore(duration!)[1],
                              size: 0.13,
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 12),
                      OutlineText(
                        text: 'Skormu: ${_countScore(duration!)[0]}',
                        color: Colors.white,
                        size: 24,
                        fontWeight: FontWeight.w600,
                        outlineColor: purpleColor,
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Button(
                            width: width,
                            text: 'Kembali',
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/home', (route) => false);
                            }),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  _countScore(int duration) {
    int maxDuration = 180;
    int star = 0;
    int score = 100 - (duration / maxDuration * 100).round();
    if (score <= 100 && score > 66) {
      star = 3;
    } else if (score <= 66 && score > 33) {
      star = 2;
    } else if (score <= 33 && score > 0) {
      star = 1;
    } else {
      star = 0;
    }

    return [score, star];
  }

  _countTime(int duration) {
    int minute = duration ~/ 60;
    int second = duration % 60;
    return [minute, second];
  }

  final _confettiController =
      ConfettiController(duration: const Duration(seconds: 3));
}
