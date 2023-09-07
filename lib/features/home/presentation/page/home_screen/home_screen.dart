import 'package:dental_hero/core/common/activity.dart';
import 'package:dental_hero/core/common/navigation/navigation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffE9F3FF),
      appBar: _buildAppbar(height, width),
      body: _buildBody(height, width),
      bottomNavigationBar: _buildBottomNavbar(height, width),
    );
  }

  _buildAppbar(double height, double width) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height * 0.1),
      child: AppBar(
        backgroundColor: Color(0xffE9F3FF),
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
              // clipBehavior: Clip.antiAlias,
              width: double.infinity,
              height: height * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Halo, Anya!",
                      style: GoogleFonts.fredoka(
                          color: Color(0xff6A658A),
                          fontSize: 21,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            'assets/images/icon_settings.png',
                          ),
                          iconSize: 48,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {},
                        ),
                        SizedBox(width: 4),
                        IconButton(
                          icon: Image.asset(
                            'assets/images/icon_album.png',
                          ),
                          iconSize: 48,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  // _buildBody() {
  //   return BlocBuilder<NavigationCubit, NavigationState>(
  //     builder: (context, state) {
  //       // int index = state.index;
  //       List<Step> steps = [
  //         Step(
  //           title: Container(
  //             height: 80,
  //             width: double.infinity,
  //             // color: Colors.green,
  //             decoration: BoxDecoration(
  //               border: Border.all(
  //                 color: Colors.blue,
  //                 width: 4,
  //               ),
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //             child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   Text('Foto Gigi'),
  //                   ElevatedButton(onPressed: () {}, child: Text('Ambil'))
  //                 ]),
  //           ),
  //           content: SizedBox.shrink(),
  //         ),
  //         Step(
  //           title: Text('11 Agustus 2023'),
  //           content: Activity(),
  //         ),
  //         Step(
  //           title: Text('11 Agustus 2023'),
  //           content: Activity(),
  //         ),
  //       ];

  //       return ListView(
  //         children: [
  //           Stepper(
  //             currentStep:
  //                 steps.length - 1 - state.index, // Reverse the step index
  //             onStepTapped: (index) {
  //               context.read<NavigationCubit>(); //Change the navbar item
  //             },
  //             steps: steps.reversed.toList(), // Reverse the order of steps
  //             controlsBuilder: (context, details) {
  //               return const SizedBox.shrink();
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  _buildBody(double height, double width) {}

  _buildBottomNavbar(double height, double width) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xff6A658A), width: 1.0),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(8.0),
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
        // clipBehavior: Clip.antiAlias,
        width: double.infinity,
        height: height * 0.1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  child: Image.asset('assets/images/scan.png',
                      width: width * 0.42)),
              GestureDetector(
                child:
                    Image.asset('assets/images/rank.png', width: width * 0.42),
              ),
            ],
          ),
        ));
  }
}