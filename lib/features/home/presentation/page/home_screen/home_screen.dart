import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';
import 'package:dental_hero/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_bloc.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_events.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_state.dart';
import 'package:dental_hero/features/home/presentation/page/test_page.dart';
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
      body: _buildBody(context, height, width),
      bottomNavigationBar: _buildBottomNavbar(context, height, width),
      floatingActionButton: IconButton(
        icon: Image.asset('assets/images/icon_calendar.png'),
        iconSize: 70,
        padding: const EdgeInsets.only(left: 8),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ConfettiScreen();
          }));
        },
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
                border: Border.all(color: purpleColor, width: 1.0),
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
                          color: purpleColor,
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
                          onPressed: () {
                            Navigator.pushNamed(context, '/album');
                          },
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

  _buildBody(BuildContext context, double height, double width) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
      ),
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        final activityGroups = state.activityGroups ?? {};
        final keys = activityGroups.keys.toList();

        keys.sort((a, b) => a.compareTo(b));

        if (state is HomeLoading || state is HomeInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: 32,
          itemBuilder: (context, index) {
            if (index == 0) {
              return CustomTimelineTile(
                isFirst: true,
                isActive: true,
                number: 1,
                child: FotoGigi(isCompleted: true),
              );
            }

            if (index == 31) {
              return CustomTimelineTile(
                isLast: true,
                isActive: false,
                number: 32,
                child: FotoGigi(isCompleted: false),
              );
            }

            final groupDate = keys[index - 1];

            return CustomTimelineTile(
                isActive: _isNow(groupDate),
                number: index + 1,
                child: ActivityCard(
                  activityGroup: activityGroups[groupDate] ?? [],
                  isActive: _isNow(keys[index - 1]),
                  date: groupDate,
                ));
          },
        );
      }),
    );
  }

  bool _isNow(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  _buildBottomNavbar(BuildContext context, double height, double width) {
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
                onTap: () {
                  Navigator.pushNamed(context, '/statistic');
                },
                child:
                    Image.asset('assets/images/rank.png', width: width * 0.42),
              ),
            ],
          ),
        ));
  }
}
