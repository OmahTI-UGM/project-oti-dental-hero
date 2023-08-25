import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Buat Akun'),
            Text('Nama Lengkap'),
            TextField(),
            Text('Tanggal lahir'),
            TextField(),
            Text('Email'),
            TextField(),
            Text('Jenis disabilitas'),
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
              child: Text('Buat Akun'),
              onPressed: () {},
            )
          ]),
    );
  }
}
