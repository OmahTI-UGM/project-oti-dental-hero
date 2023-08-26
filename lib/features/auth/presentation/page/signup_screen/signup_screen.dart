import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_bloc.dart';
import '../../blocs/auth_event.dart';
import '../../blocs/auth_state.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, dynamic>(
          listener: (_, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Success'),
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
    final TextEditingController emailController = TextEditingController();

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Buat Akun'),
          const Text('Nama Lengkap'),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Masukkan nama lengkap',
            ),
            controller: nameController,
          ),
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
          const Text('Email'),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Masukkan email',
            ),
            controller: emailController,
          ),
          const Text('Jenis disabilitas'),
          DropdownButton(
            items: ['blind', 'deaf', 'autism', 'down syndrome']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {},
          ),
          ElevatedButton(
            child: const Text('Buat Akun'),
            onPressed: () {
              print({
                'name': nameController.text,
                'birthDate': birthDateController.text,
                'email': emailController.text,
              });

              if (birthDateController.text.isNotEmpty &&
                  nameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty) {
                BlocProvider.of<AuthBloc>(context).add(
                  RegisterEvent(
                    fullName: nameController.text,
                    birthDate: DateTime.parse(birthDateController.text),
                    email: emailController.text,
                    disability: 'blind',
                  ),
                );
              }
            },
          )
        ]);
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
