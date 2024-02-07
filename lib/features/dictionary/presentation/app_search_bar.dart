import 'dart:async';

import 'package:dictionary/features/auth/providers/auth_repository_provider.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_search_text_provider.dart';
import 'package:dictionary/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSearchBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const AppSearchBar(this.title, {super.key});
  final String title;

  @override
  ConsumerState<AppSearchBar> createState() => _AppSearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(130);
}

class _AppSearchBarState extends ConsumerState<AppSearchBar> {
  final TextEditingController _controller = TextEditingController();
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.unfocus();
    logger.i('AppSearchBar initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    focusNode: _focusNode,
                    controller: _controller,
                    onChanged: (value) {},
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
                          .updateText(_controller.value.text);
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
        ]);
  }
}
