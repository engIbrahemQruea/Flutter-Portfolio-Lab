import 'package:advanced/018_introduction_to_cryptography/02_hasing/hashing_screen.dart';
import 'package:advanced/018_introduction_to_cryptography/02_hasing/hashing_tow_screen.dart';
import 'package:advanced/018_introduction_to_cryptography/03_symmetric/symmetric_screen.dart';
import 'package:flutter/material.dart';

class MainCryptographyScreen extends StatelessWidget {
  const MainCryptographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cryptography Screen'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade300,
        elevation: 0,
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HashingScreen()),
              );
            },
            label: Text('Hasing Algorithem Screen'),
            icon: Icon(Icons.fingerprint),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HashingTowScreen(),
                ),
              );
            },
            label: Text('Hasing Algorithem Tow Screen'),
            icon: Icon(Icons.fingerprint),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SymmetricAesScreen(),
                ),
              );
            },
            label: Text('Symmetric AES Screen'),
            icon: Icon(Icons.lock),
          ),
        ],
      ),
    );
  }
}
