import 'package:dictionary/features/auth/data/fake_auth_repository.dart';
import 'package:dictionary/features/auth/presentation/auth_screen.dart';
import 'package:dictionary/features/auth/providers/auth_repository_bootstrap_provider.dart';
import 'package:dictionary/features/dictionary/data/dictionaryapi/dictionaryapi_repository.dart';
import 'package:dictionary/features/dictionary/data/fake_dictionary_repository.dart';
import 'package:dictionary/features/dictionary/domain/word_meaning.dart';
import 'package:dictionary/features/dictionary/presentation/dictionary_screen.dart';
import 'package:dictionary/features/dictionary/presentation/word_meaning_card.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_repository_bootstrap_provider.dart';
import 'package:dictionary/features/startup/app_startup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../robot.dart';

void main() {
  testGoldens('golden - auth screen', (tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await loadAppFonts();
    final r = Robot(tester);
    await r.pumpMyApp();
    await expectLater(
      find.byType(AuthScreen),
      matchesGoldenFile(
        'auth_screen.png',
      ),
    );
  });

  testGoldens(
    'golden - auth screen, all',
    (tester) async {
      WidgetsFlutterBinding.ensureInitialized();
      await loadAppFonts();

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [
            Device.phone,
            Device.iphone11,
            Device.tabletPortrait,
            Device.tabletLandscape,
            const Device(name: 'hi-res', size: Size(1179, 2556)),
          ],
        )
        ..addScenario(
          name: 'dictionary screen',
          widget: ProviderScope(
            overrides: [
              dictionaryRepositoryBootstrapProvider.overrideWithValue(
                DictionaryApiRepository(),
              ),
              authRepositoryBootstrapProvider.overrideWithValue(
                FakeAuthRepository(),
              )
            ],
            child: const AppStartup(
              child: DictionaryScreen(),
            ),
          ),
        )
        ..addScenario(
          name: 'word meaning card',
          widget: ProviderScope(
            overrides: [
              dictionaryRepositoryBootstrapProvider.overrideWithValue(
                DictionaryApiRepository(),
              ),
              authRepositoryBootstrapProvider.overrideWithValue(
                FakeAuthRepository(),
              )
            ],
            child: AppStartup(
              child: WordMeaningCard(
                wordMeaning: WordMeaning(
                  partDefinitions: [
                    "definition 1",
                    "definition 2",
                    "definition 3"
                  ],
                  partOfSpeach: "adjective",
                ),
              ),
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'sign_in_page_multiple_scenarios');
    },
  );
}
