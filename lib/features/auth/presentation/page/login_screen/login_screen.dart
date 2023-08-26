import 'package:dental_hero/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_event.dart';
import '../../blocs/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, dynamic>(
          listener: (_, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Success, hello ${state.user?.fullName}'),
                ),
              );
            }

            if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.message),
                ),
              );
            }
          },
          child: _buildBody(context)),
    );
  }

  _buildBody(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController birthDateController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Column(
          children: [
            Text("Selamat Datang ke", style: TextStyle(fontSize: 24)),
            Text(
              "Dental",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              'Hero',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text('(misal ada tagline)', style: TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 40),
        const Text(
          'Nama Lengkap',
          textAlign: TextAlign.start,
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Masukkan nama lengkap',
          ),
          controller: nameController,
        ),
        // Birth Date
        const Text('Tanggal lahir'),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Masukkan tanggal lahir',
            prefixIcon: Icon(Icons.calendar_today),
            filled: true,
          ),
          readOnly: true,
          controller: birthDateController,
          onTap: () => _selectDate(context, birthDateController),
        ),
        ElevatedButton(
          child: const Text('Masuk ke Akun'),
          onPressed: () {
            print({
              'name': nameController.text,
              'birthDate': birthDateController.text,
            });
            if (birthDateController.text.isNotEmpty &&
                nameController.text.isNotEmpty) {
              BlocProvider.of<AuthBloc>(context).add(
                LoginEvent(
                  fullName: nameController.text,
                  birthDate: DateTime.parse(birthDateController.text),
                ),
              );
            }
          },
        )
      ]),
    );
  }

  void _selectDate(
      BuildContext context, TextEditingController dateController) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dateController.text = picked.toString();
    }
  }
}
