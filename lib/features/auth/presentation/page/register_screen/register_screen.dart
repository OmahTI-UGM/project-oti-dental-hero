import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/features/auth/presentation/blocs/ui/dropdown_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  RegisterScreen({super.key});

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
    final dropDownItems =
        ['blind', 'deaf', 'autism', 'down syndrome'].map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/images/background.png'),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Text(
                            'Buat Akun',
                            style: GoogleFonts.fredoka(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.black,
                            ),
                          ),
                          Text(
                            'Buat Akun',
                            style: GoogleFonts.fredoka(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: redColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 27),
                      Column(
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
                                    border: InputBorder.none),
                                controller: nameController,
                                validator: (val) => val!.isEmpty
                                    ? 'Nama lengkap tidak boleh kosong'
                                    : null),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Nama Panggilan',
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
                                    hintText: 'Ketik nama panggilan anak',
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    border: InputBorder.none),
                                controller: nicknameController,
                                validator: (val) => val!.isEmpty
                                    ? 'Nama panggilan tidak boleh kosong'
                                    : null),
                          ),
                          const SizedBox(height: 20),
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
                              textInputAction: TextInputAction.next,
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
                          const SizedBox(height: 20),
                          Text(
                            'Email',
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
                                      'Email anak atau orang tua yang dapat dihubungi',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 12),
                                  border: InputBorder.none,
                                ),
                                controller: emailController,
                                validator: (val) => val!.isEmpty
                                    ? 'Email tidak boleh kosong'
                                    : null),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Jenis Disabilitas',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.fredoka(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 4),
                          BlocBuilder<DropdownBloc, DropdownState>(
                            builder: (context, state) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  child: DropdownButton<String>(
                                    // style: GoogleFonts.fredoka(
                                    //   fontSize: 15,
                                    // ),
                                    isExpanded: true,
                                    value: state.selectedValue,
                                    items: dropDownItems,
                                    onChanged: (value) {
                                      BlocProvider.of<DropdownBloc>(context)
                                          .add(DropdownEvent(value!));
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
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
                                  'Buat Akun',
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
                                  'Buat Akun',
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
                          if (birthDateController.text.isNotEmpty &&
                              nameController.text.isNotEmpty &&
                              emailController.text.isNotEmpty) {
                            BlocProvider.of<AuthBloc>(context).add(
                              RegisterEvent(
                                fullName: nameController.text,
                                birthDate:
                                    DateTime.parse(birthDateController.text),
                                email: emailController.text,
                                disability:
                                    BlocProvider.of<DropdownBloc>(context)
                                        .state
                                        .selectedValue,
                              ),
                            );
                          }
                        },
                      ),
                    ]),
              ),
            ),
          ],
        ),
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
      TextInputAction.next;
    }
  }
}
