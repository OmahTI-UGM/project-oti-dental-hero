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
  const ResultScreen({super.key, this.duration});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffE9F3FF),
      body: _buildBody(height, width, context),
    );
  }

  _buildBody(double height, double width, BuildContext context) {
    // Use a separate context here to access the ConfettiBloc
    final confettiBloc = BlocProvider.of<ConfettiBloc>(context);

    // Start the confetti animation when the page opens
    Future.delayed(Duration.zero, () {
      confettiBloc.add(ShowConfetti());
    });
    return BlocBuilder<ConfettiBloc, ConfettiState>(
      builder: (context, state) {
        return Stack(
          children: [
            BlocBuilder<ConfettiBloc, ConfettiState>(
              builder: (context, state) {
                if (state is ConfettiPlaying) {
                  return Center(
                    child: ConfettiWidget(
                      confettiController: ConfettiController(
                        duration: const Duration(seconds: 3),
                      ),
                      blastDirectionality: BlastDirectionality.explosive,
                      shouldLoop: false,
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
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
}
