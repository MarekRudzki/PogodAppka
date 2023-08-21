// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:country_flags/country_flags.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:pogodappka/features/language/language.dart';
import 'package:pogodappka/features/language/presentation/blocs/language_bloc/language_bloc.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return PopupMenuButton(
          color: const Color.fromARGB(255, 54, 202, 184),
          child: const Icon(
            Icons.language,
            color: Colors.white,
          ),
          onSelected: (value) {
            context.read<LanguageBloc>().add(
                  ChangeLanguage(
                    selectedLanguage:
                        value == 'polish' ? Language.polish : Language.english,
                  ),
                );
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: 'english',
              child: Row(
                children: [
                  CountryFlag.fromLanguageCode(
                    'en',
                    width: 22,
                    height: 22,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'English',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'polish',
              child: Row(
                children: [
                  CountryFlag.fromCountryCode(
                    'PL',
                    width: 22,
                    height: 22,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Polski',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
