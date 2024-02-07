import 'dart:async';

import 'package:dictionary/features/auth/providers/auth_repository_provider.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_search_text_provider.dart';
import 'package:dictionary/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppSearchBar extends HookConsumerWidget implements PreferredSizeWidget {
  const AppSearchBar(this.title, {super.key});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final controller = useTextEditingController();
    focusNode.unfocus();
    Timer? debounce;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: focusNode,
                  controller: controller,
                  onChanged: (value) {
                    if (debounce?.isActive ?? false) {
                      logger.i('debounce cancelled');
                      debounce!.cancel();
                    }

                    // Note. instead of hardcoding the debounce time, we could use a configuration value
                    debounce = Timer(const Duration(milliseconds: 1000), () {
                      ref
                          .read(dictionarySearchTextProvider.notifier)
                          .updateText(controller.value.text);
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    ref
                        .read(dictionarySearchTextProvider.notifier)
                        .updateText(controller.value.text);
                  },
                  icon: const Icon(Icons.search),
                );
              }),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              ref.read(authRepositoryProvider).signOut();
            },
            icon: const Icon(Icons.logout))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
}
