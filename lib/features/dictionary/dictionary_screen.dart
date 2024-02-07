import 'package:dictionary/providers/auth_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryScreen extends ConsumerWidget {
  const DictionaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (context) {
          var email = ref.read(authRepositoryProvider).getUser()?.email;
          return Text('Dictionary. Welcome: [$email]');
        }),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(authRepositoryProvider).signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
