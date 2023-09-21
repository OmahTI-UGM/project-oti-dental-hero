import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/common/date_formatter.dart';
import 'package:dental_hero/features/gallery/presentation/blocs/ui/album_switch_cubit.dart';
import 'package:dental_hero/features/gallery/presentation/widget/album_switch.dart';
import 'package:dental_hero/features/gallery/presentation/widget/photo_card.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_bloc.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class AlbumScreen extends StatelessWidget {
  final int day = 11;
  final String month = 'Agustus';
  final int year = 2023;

  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AlbumSwitchCubit(),
      child: Scaffold(
        backgroundColor: lightBlueColor,
        appBar: _buildAppbar(height, width, context),
        body: _buildBody(height, width, context),
      ),
    );
  }

  _buildAppbar(double height, double width, BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height * 0.1),
      child: AppBar(
        automaticallyImplyLeading: false,
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Album Foto",
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
    final comparisonSnapshot =
        BlocProvider.of<HomeBloc>(context).state.comparisonSnapshot;

    final before = comparisonSnapshot?.before;
    final beforeData = comparisonSnapshot?.beforeImageUrls;

    final after = comparisonSnapshot?.after;
    final afterData = comparisonSnapshot?.afterImageUrls;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            const AlbumSwitch(),
            const SizedBox(
              height: 18,
            ),
            BlocBuilder<AlbumSwitchCubit, AlbumSwitchState>(
              builder: (context, state) {
                if (state == AlbumSwitchState.before) {
                  return _buildBeforeColumn(context, before!, beforeData);
                } else if (state == AlbumSwitchState.after) {
                  return _buildAfterColumn(context, after!, afterData);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBeforeColumn(
    BuildContext context, DateTime beforeDate, List<String>? beforeImageUrls) {
  if (beforeImageUrls == null) {
    return const Text('Tidak ada foto gigi sebelum');
  }

  final List<PhotoCard> photoCards = [
    PhotoCard(
      image: beforeImageUrls[0],
      title: 'Foto Bibir',
    ),
    PhotoCard(
      image: beforeImageUrls[1],
      title: 'Foto Permukaan Depan Gigi',
    ),
    PhotoCard(
      image: beforeImageUrls[2],
      title: 'Foto Permukaan Kunyah Gigi Bawah',
    ),
    PhotoCard(
      image: beforeImageUrls[3],
      title: 'Foto Permukaan Kunyah Gigi Atas',
    ),
  ];

  return Column(children: [
    Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: purpleColor, width: 1.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foto Gigi Sebelum',
            style: GoogleFonts.fredoka(
                fontSize: 21, color: purpleColor, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Text(
            'Diambil pada tanggal ${DateFormatter.galleryScreenDate(beforeDate)}',
            style: GoogleFonts.fredoka(
                fontSize: 15,
                color: darkGrayColor,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    ),
    const SizedBox(height: 16),
    ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: beforeImageUrls.length, // Number of items in your list
      shrinkWrap: true,
      itemBuilder: (context, index) {
        // Create a list of PhotoCard widgets

        // Return the PhotoCard at the current index
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: photoCards[index],
        );
      },
    )
  ]);
}

Widget _buildAfterColumn(
    BuildContext context, DateTime afterDate, List<String>? afterImageUrls) {
  if (afterImageUrls == null) {
    return const Text('Tidak ada foto gigi sebelum');
  }

  final List<PhotoCard> photoCards = [
    PhotoCard(
      image: afterImageUrls[0],
      title: 'Foto Bibir',
    ),
    PhotoCard(
      image: afterImageUrls[1],
      title: 'Foto Permukaan Depan Gigi',
    ),
    PhotoCard(
      image: afterImageUrls[2],
      title: 'Foto Permukaan Kunyah Gigi Bawah',
    ),
    PhotoCard(
      image: afterImageUrls[3],
      title: 'Foto Permukaan Kunyah Gigi Atas',
    ),
  ];
  return Column(children: [
    Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: purpleColor, width: 1.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foto Gigi Sesudah',
            style: GoogleFonts.fredoka(
                fontSize: 21, color: purpleColor, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Text(
            'Diambil pada tanggal ${DateFormatter.galleryScreenDate(afterDate)}',
            style: GoogleFonts.fredoka(
                fontSize: 15,
                color: darkGrayColor,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    ),
    const SizedBox(height: 16),
    ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4, // Number of items in your list
      shrinkWrap: true,
      itemBuilder: (context, index) {
        // Return the PhotoCard at the current index
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: photoCards[index],
        );
      },
    )
  ]);
}
