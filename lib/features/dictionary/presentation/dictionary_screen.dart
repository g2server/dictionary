import 'package:dictionary/features/auth/providers/auth_repository_provider.dart';
import 'package:dictionary/features/dictionary/presentation/app_search_bar.dart';
import 'package:dictionary/features/dictionary/presentation/word_definitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryScreen extends ConsumerWidget {
  const DictionaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var email = ref.read(authRepositoryProvider).getUser()?.email;

    return Scaffold(
      appBar: AppSearchBar('Dictionary. Welcome: [$email]'),
      body: const Center(
        child: WordDefinitions(),
      ),
    );
  }
}
