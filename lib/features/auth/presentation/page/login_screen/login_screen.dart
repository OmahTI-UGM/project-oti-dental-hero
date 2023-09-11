import 'package:dental_hero/core/common/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, dynamic>(listener: (_, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text('Success, hello ${state.user?.fullName}'),
            ),
          );
          Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
        }

        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message),
            ),
          );
        }
      }, child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return _buildBody(context);
        },
      )),
    );
  }

  _buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Text("Selamat Datang ke",
                              style: GoogleFonts.fredoka(
                                  fontSize: 17, fontWeight: FontWeight.w500)),
                          Image.asset(
                            'assets/images/logo.png',
                            width: MediaQuery.of(context).size.width * 0.45,
                          ),
                          Text('Mulai Perjalananmu ke Gigi Sehat!',
                              style: GoogleFonts.fredoka(
                                  fontSize: 15, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Lengkap',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.fredoka(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  style: GoogleFonts.fredoka(
                                    fontSize: 15,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText:
                                        'Ketik nama lengkap anak tanpa disingkat',
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    border: InputBorder.none,
                                  ),
                                  controller: nameController,
                                  validator: (val) => val!.isEmpty
                                      ? 'Nama lengkap tidak boleh kosong'
                                      : null),
                            ),
                            // Birth Date
                            const SizedBox(height: 18),
                            Text(
                              'Tanggal Lahir',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.fredoka(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: TextFormField(
                                style: GoogleFonts.fredoka(
                                  fontSize: 15,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'dd/mm/yyyy',
                                  prefixIcon: Icon(Icons.calendar_today),
                                  border: InputBorder.none,
                                ),
                                readOnly: true,
                                controller: birthDateController,
                                onTap: () =>
                                    _selectDate(context, birthDateController),
                              ),
                            ),
                            const SizedBox(height: 18),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: shadeBlueColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.40),
                                      offset: const Offset(4, -4),
                                      blurRadius: 0,
                                      spreadRadius: 0,
                                      inset: true,
                                    ),
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Text(
                                        'Masuk ke Akun',
                                        style: GoogleFonts.fredoka(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 3
                                            ..color = Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Masuk ke Akun',
                                        style: GoogleFonts.fredoka(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                print({
                                  'name': nameController.text,
                                  'birthDate': birthDateController.text,
                                });
                                if (birthDateController.text.isNotEmpty &&
                                    nameController.text.isNotEmpty) {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    LoginEvent(
                                      fullName: nameController.text,
                                      birthDate: DateTime.parse(
                                          birthDateController.text),
                                    ),
                                  );
                                }
                              },
                            ),
                          ]),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      child: Text(
                        'Buat Akun Baru',
                        style: GoogleFonts.fredoka(
                          color: darkBlueColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/register', (_) => false);
                      },
                    ),
                  ]),
            ),
          ),
        ],
      ),
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
