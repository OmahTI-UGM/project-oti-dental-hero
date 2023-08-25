import 'package:dental_hero/core/common/navigation/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar());
  }

  _buildAppbar() {
    return AppBar(
      title: Text("Dental Hero"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Center(
            child: Container(
          child: Text('Hello Dental'),
        ));
      },
    );
  }
}
