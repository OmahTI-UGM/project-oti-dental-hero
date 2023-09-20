// import 'package:confetti/confetti.dart';
// import 'package:dental_hero/features/activity/presentation/blocs/confetti/confetti_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ConfettiScreen extends StatefulWidget {
//   @override
//   _ConfettiScreenState createState() => _ConfettiScreenState();
// }

// class _ConfettiScreenState extends State<ConfettiScreen> {
//   @override
//   void initState() {
//     super.initState();

//     // Trigger confetti activation after a short delay when the widget is initialized
//     Future.delayed(const Duration(milliseconds: 100), () {
//       context.read<ConfettiCubit>().activateConfetti();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Confetti Animation'),
//       ),
//       body: BlocBuilder<ConfettiCubit, ConfettiState>(
//         builder: (context, state) {
//           if (state == ConfettiState.active) {
//             _confettiController.play();
//             return Center(
//               child: ConfettiWidget(
//                 confettiController: _confettiController,
//                 blastDirection:
//                     -3.14 / 2, // Change this value to adjust the direction
//                 emissionFrequency:
//                     0.05, // Increase this value for more confetti
//                 numberOfParticles:
//                     50, // Adjust the number of confetti particles
//                 gravity: 0.07, // Add gravity to the confetti
//                 maxBlastForce: 40,
//                 shouldLoop: false,
//                 colors: const [
//                   Color(0xffFF6685),
//                   Color(0xffFF66C2),
//                   Color(0xff66B8FF),
//                   Color(0xff8C66FF),
//                   Color(0xffB366FF),
//                   Color(0xffFF8C66),
//                   Color(0xffEDFF66),
//                   Color(0xff66FFAB),
//                 ],
//               ),
//             );
//           }
//           return const Center(
//             child:
//                 CircularProgressIndicator(), // You can replace this with any loading indicator
//           );
//         },
//       ),
//     );
//   }

//   final _confettiController =
//       ConfettiController(duration: const Duration(seconds: 3));
// }

import 'package:confetti/confetti.dart';
import 'package:dental_hero/features/activity/presentation/blocs/confetti/confetti_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfettiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Trigger confetti activation after a short delay when the widget is first built
    Future.delayed(const Duration(milliseconds: 100), () {
      context.read<ConfettiCubit>().activateConfetti();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confetti Animation'),
      ),
      body: BlocBuilder<ConfettiCubit, ConfettiState>(
        builder: (context, state) {
          if (state == ConfettiState.active) {
            _confettiController.play();
            return Center(
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
            );
          }
          return const Center(
            child:
                CircularProgressIndicator(), // You can replace this with any loading indicator
          );
        },
      ),
    );
  }

  final _confettiController =
      ConfettiController(duration: const Duration(seconds: 3));
}
