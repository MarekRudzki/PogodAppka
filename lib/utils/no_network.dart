import 'package:flutter/material.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 202, 184),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 8, 180, 160),
        title: const Text(
          'Brak połączenia z Internetem',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Do korzystania z aplikacji wymagane jest połączenie z siecią.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/no-network.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            const SizedBox(height: 15),
            const Text(
              'Włącz Inernet, a aplikacja sama się odświeży!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
