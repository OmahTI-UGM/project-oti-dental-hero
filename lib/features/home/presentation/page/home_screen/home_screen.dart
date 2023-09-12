import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_bloc.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_events.dart';
import 'package:dental_hero/features/home/presentation/widget/activity_card.dart';
import 'package:dental_hero/features/home/presentation/widget/foto_gigi.dart';
import 'package:dental_hero/features/home/presentation/widget/timeline_tile.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    _fetchActivities(context);

    return Scaffold(
      backgroundColor: lightBlueColor,
      appBar: _buildAppbar(context, height, width),
      body: _buildBody(height, width),
      bottomNavigationBar: _buildBottomNavbar(height, width),
      floatingActionButton: IconButton(
        icon: Image.asset('assets/images/icon_calendar.png'),
        iconSize: 70,
        padding: const EdgeInsets.only(left: 8),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  _buildAppbar(BuildContext context, double height, double width) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height * 0.1),
      child: AppBar(
        backgroundColor: const Color(0xffE9F3FF),
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xff6A658A), width: 1.0),
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
                      "Halo, ${BlocProvider.of<AuthBloc>(context).state.user?.fullName ?? "null"}!",
                      style: GoogleFonts.fredoka(
                          color: const Color(0xff6A658A),
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
                          onPressed: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                        ),
                        const SizedBox(width: 4),
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

  _fetchActivities(BuildContext context) {
    final userId = BlocProvider.of<AuthBloc>(context).state.user?.id ?? "";
    BlocProvider.of<HomeBloc>(context).add(LoadActivitiesEvent(userId: userId));
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

  _buildBody(double height, double width) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
      ),
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomTimelineTile(
            isFirst: true,
            isLast: false,
            isPast: false,
            isActive: true,
            child: FotoGigi(isCompleted: true),
            number: 1,
          ),
          CustomTimelineTile(
            isFirst: false,
            isLast: false,
            isPast: false,
            isActive: false,
            child: FotoGigi(isCompleted: false),
            number: 2,
          ),
          const CustomTimelineTile(
            isFirst: false,
            isLast: false,
            isPast: false,
            isActive: false,
            child: ActivityCard(
              isActive: false,
            ),
            number: 4,
          ),
          const CustomTimelineTile(
            isFirst: false,
            isLast: false,
            isPast: false,
            isActive: true,
            child: ActivityCard(
              isActive: true,
            ),
            number: 3,
          ),
          const CustomTimelineTile(
            isFirst: false,
            isLast: false,
            isPast: false,
            isActive: false,
            child: ActivityCard(
              isActive: false,
            ),
            number: 4,
          ),
          const CustomTimelineTile(
            isFirst: false,
            isLast: true,
            isPast: false,
            isActive: false,
            child: ActivityCard(
              isActive: false,
            ),
            number: 4,
          ),
        ],
      ),
    );
  }

  _buildBottomNavbar(double height, double width) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xff6A658A), width: 1.0),
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
