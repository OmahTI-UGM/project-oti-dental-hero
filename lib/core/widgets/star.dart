import 'package:flutter/material.dart';

class StarWidget extends StatelessWidget {
  final int star;
  late double size;
  StarWidget({super.key, required this.star, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < star; i++)
          Image.asset(
            'assets/images/star.png',
            width: MediaQuery.of(context).size.width * size,
          ),
        for (int i = 0; i < 3 - star; i++)
          Image.asset(
            'assets/images/star_white.png',
            width: MediaQuery.of(context).size.width * size,
          ),
      ],
    );
  }
}
