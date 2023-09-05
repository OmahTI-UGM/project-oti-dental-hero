import 'package:dental_hero/core/common/activity.dart';
import 'package:dental_hero/core/common/navigation/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavbar(height, width),
    );
  }

  _buildAppbar() {
    return AppBar(
      title: Text("Dental Hero"),
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.photo),
          onPressed: () {},
        ),
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        // int index = state.index;
        List<Step> steps = [
          Step(
            title: Container(
              height: 80,
              width: double.infinity,
              // color: Colors.green,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Foto Gigi'),
                    ElevatedButton(onPressed: () {}, child: Text('Ambil'))
                  ]),
            ),
            content: SizedBox.shrink(),
          ),
          Step(
            title: Text('11 Agustus 2023'),
            content: Activity(),
          ),
          Step(
            title: Text('11 Agustus 2023'),
            content: Activity(),
          ),
        ];

        return ListView(
          children: [
            Stepper(
              currentStep:
                  steps.length - 1 - state.index, // Reverse the step index
              onStepTapped: (index) {
                context.read<NavigationCubit>(); //Change the navbar item
              },
              steps: steps.reversed.toList(), // Reverse the order of steps
              controlsBuilder: (context, details) {
                return const SizedBox.shrink();
              },
            )
          ],
        );
      },
    );
  }

  _buildBottomNavbar(double height, double width) {
    return Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.blue)),
        ),
        width: double.infinity,
        height: height * 0.08,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: height * 0.08,
                  width: width * 0.35,
                  color: Colors.blue,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code_scanner_outlined),
                        SizedBox(width: 8),
                        Text('Scan \nAR Card')
                      ]),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: height * 0.08,
                  width: width * 0.35,
                  color: Colors.blue,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bar_chart),
                        SizedBox(width: 8),
                        Text('Statistik'),
                      ]),
                ),
              ),
            ],
          ),
        ));
  }
}
