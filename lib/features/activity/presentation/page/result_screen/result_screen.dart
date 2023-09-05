import 'package:dental_hero/core/widgets/star.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  late int? duration;
  ResultScreen({super.key, this.duration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Skor' + _countScore(duration!)[0].toString()),
          Text('Waktu' +
              _countTime(duration!)[0].toString() +
              ':' +
              _countTime(duration!)[1].toString()),
          StarWidget(star: _countScore(duration!)[1]),
          ElevatedButton(onPressed: () {}, child: Text('Kembali ke menu')),
        ],
      ),
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
