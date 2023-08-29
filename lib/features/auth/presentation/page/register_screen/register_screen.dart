import 'package:dental_hero/features/auth/presentation/blocs/ui/dropdown_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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

    final dropDownItems =
        ['blind', 'deaf', 'autism', 'down syndrome'].map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

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
          BlocBuilder<DropdownBloc, DropdownState>(
            builder: (context, state) {
              return DropdownButton<String>(
                value: state.selectedValue,
                items: dropDownItems,
                onChanged: (value) {
                  BlocProvider.of<DropdownBloc>(context)
                      .add(DropdownEvent(value!));
                },
              );
            },
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
                    disability: BlocProvider.of<DropdownBloc>(context)
                        .state
                        .selectedValue,
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 8),
          TextButton(
            child: Text(
              'Masuk ke Akun',
              style: TextStyle(
                color: Colors.grey[700],
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (_) => false);
            },
          ),
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
