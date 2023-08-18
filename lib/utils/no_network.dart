import 'package:flutter/material.dart';
import 'package:pogodappka/utils/l10n/localization.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 202, 184),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 8, 180, 160),
        title: Text(
          context.l10n.noNetworkAppBar,
          style: const TextStyle(
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
            Text(
              context.l10n.noNetworkMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
            Text(
              context.l10n.noNetworkInstructions,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
