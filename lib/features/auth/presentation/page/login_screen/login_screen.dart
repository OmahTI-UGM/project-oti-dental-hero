import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
          SizedBox(height: 40),
          Text(
            'Nama Lengkap',
            textAlign: TextAlign.start,
          ),
          TextField(),
          Text('Tanggal lahir'),
          TextField(),
          ElevatedButton(
            child: Text('Masuk ke Akun'),
            onPressed: () {},
          )
        ]),
      ),
    );
  }
}
