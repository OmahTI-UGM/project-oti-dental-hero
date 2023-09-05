import 'package:flutter/material.dart';

class StarWidget extends StatelessWidget {
  late int star;
  StarWidget({super.key, required this.star});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < star; i++)
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
        for (int i = 0; i < 3 - star; i++)
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
      ],
    );
  }
}
