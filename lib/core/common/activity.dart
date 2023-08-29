import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: 140,
          width: 140,
          // color: Colors.green,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.sunny, size: 70),
              ElevatedButton(
                child: Text('Mulai'),
                onPressed: () {},
              )
            ],
          ),
        ),
        Container(
          height: 140,
          width: 140,
          // color: Colors.green,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.nightlight, size: 70),
              ElevatedButton(
                child: Text('Mulai'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ]),
    );
  }
}
