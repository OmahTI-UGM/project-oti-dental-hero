import 'package:dental_hero/features/augmented_reality/presentation/blocs/qr/qr_bloc.dart';
import 'package:dental_hero/features/augmented_reality/presentation/blocs/qr/qr_state.dart';
import 'package:dental_hero/features/augmented_reality/presentation/pages/ar_screen/ar_screen.dart';
import 'package:dental_hero/features/augmented_reality/presentation/pages/qr_screen.dart/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArMainScreen extends StatelessWidget {
  const ArMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocBuilder<QrBloc, QrState>(builder: (context, state) {
      if (state is QrVerified) {
        return const ArScreen();
      }
      return const QrScreen();
    });
  }
}
