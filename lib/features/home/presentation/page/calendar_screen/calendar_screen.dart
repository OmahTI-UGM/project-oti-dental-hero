import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_bloc.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_state.dart';
import 'package:dental_hero/features/home/presentation/widget/calendar_card.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: lightBlueColor,
      appBar: _buildAppbar(height, width, context),
      body: _buildBody(width, height, context),
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
                      "Kalender",
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

  _buildBody(double width, double height, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: blueGrayColor,
            border: Border.all(color: purpleColor),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: [
            Text(
              "Perjalanan Sikat Gigi Rutinmu",
              style: GoogleFonts.fredoka(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Expanded(
              child:
                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                final activityGroups = state.activityGroups ?? {};
                final keys = activityGroups.keys.toList();

                keys.sort((a, b) => a.compareTo(b));

                if (state is HomeLoading || state is HomeInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // 4 items per row
                  ),
                  itemCount: keys.length, // Total number of items
                  itemBuilder: (BuildContext context, int index) {
                    final groupDate = keys[index];

                    return CalendarCard(
                      index: index + 1,
                      activityGroup: activityGroups[groupDate] ?? [],
                    );
                  },
                );
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
