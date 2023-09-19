import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/common/outline_text.dart';
import 'package:dental_hero/features/auth/domain/entities/user.dart';
import 'package:dental_hero/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dental_hero/features/statistic/presentation/blocs/leaderboard/leaderboard_bloc.dart';
import 'package:dental_hero/features/statistic/presentation/blocs/leaderboard/leaderboard_event.dart';
import 'package:dental_hero/features/statistic/presentation/blocs/leaderboard/leaderboard_state.dart';
import 'package:dental_hero/features/statistic/presentation/blocs/statistic/statistic_bloc.dart';
import 'package:dental_hero/features/statistic/presentation/blocs/statistic/statistic_event.dart';
import 'package:dental_hero/features/statistic/presentation/blocs/statistic/statistic_state.dart';
import 'package:dental_hero/features/statistic/presentation/cubit/statistic_switch_cubit.dart';
import 'package:dental_hero/features/statistic/presentation/widget/leaderboard_tile.dart';
import 'package:dental_hero/features/statistic/presentation/widget/statistic_switch.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LeaderboardBloc>(context)
        .add(const FetchLeaderboardEvent());

    final userId = BlocProvider.of<AuthBloc>(context).state.user!.id;
    BlocProvider.of<StatisticBloc>(context)
        .add(FetchStatisticEvent(userId: userId!));

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => StatisticSwitchCubit(),
      child: Scaffold(
        backgroundColor: lightBlueColor,
        appBar: _buildAppbar(height, width),
        body: _buildBody(height, width, context),
      ),
    );
  }

  _buildAppbar(double height, double width) {
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
                      onPressed: () {},
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Statistik",
                      style: GoogleFonts.fredoka(
                          color: const Color(0xff6A658A),
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

  _buildBody(double height, width, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            const StatisticSwitch(),
            const SizedBox(
              height: 18,
            ),
            BlocBuilder<StatisticSwitchCubit, StatisticSwitchState>(
              builder: (context, state) {
                if (state == StatisticSwitchState.rank) {
                  return _buildRankColumn(context);
                } else if (state == StatisticSwitchState.statistik) {
                  return _buildStatistikColumn(context);
                }
                return Container();
              },
            ),
            const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }
}

Widget _buildRankColumn(BuildContext context) {
  return BlocBuilder<LeaderboardBloc, LeaderboardState>(
      builder: (context, state) {
    if (state is LeaderboardLoading || state is LeaderboardInitial) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is LeaderboardFailed) {
      return Center(
        child: Text(state.error.toString()),
      );
    }

    final List<UserEntity>? leaderboardData =
        (state as LeaderboardSuccess).leaderboard;

    if (leaderboardData == null || leaderboardData.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(children: [
      Image.asset('assets/images/trophy.png'),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              child: Column(
                children: [
                  OutlineText(
                    text: 1100.toString(),
                    size: 18,
                    color: Colors.white,
                    outlineColor: purpleColor,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sentosa Santoso Santosa',
                    style:
                        GoogleFonts.fredoka(fontSize: 12, color: purpleColor),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Column(
                children: [
                  OutlineText(
                    text: 1200.toString(),
                    size: 18,
                    color: Colors.white,
                    outlineColor: purpleColor,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Anya WakUWaaku',
                    style:
                        GoogleFonts.fredoka(fontSize: 12, color: purpleColor),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Column(
                children: [
                  OutlineText(
                    text: 1000.toString(),
                    size: 18,
                    color: Colors.white,
                    outlineColor: purpleColor,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Angkasa Nutella Carrado',
                    style:
                        GoogleFonts.fredoka(fontSize: 12, color: purpleColor),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 18),
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: purpleColor, width: 1.0),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
              color: shadeBlueColor,
              child: Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.10,
                      child: Text(
                        'No',
                        style: GoogleFonts.fredoka(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.52,
                      child: Text('Nama',
                          style: GoogleFonts.fredoka(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.18,
                      child: Text(
                        'Skor',
                        style: GoogleFonts.fredoka(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: leaderboardData.length,
              itemBuilder: (context, index) {
                final entry = leaderboardData[index];
                return LeaderboardTile(
                  rank: index + 1,
                  name: entry.fullName!,
                  score: entry.score ?? 999,
                );
              },
            )
          ],
        ),
      ),
    ]);
  });
}

Widget _buildStatistikColumn(BuildContext context) {
  return BlocBuilder<StatisticBloc, StatisticState>(builder: (context, state) {
    if (state is StatisticLoading || state is StatisticInitial) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is StatisticFailed) {
      return Center(
        child: Text(state.error.toString()),
      );
    }

    print(state.activityGroups);
    return const Text('Statistik');
  });
}
