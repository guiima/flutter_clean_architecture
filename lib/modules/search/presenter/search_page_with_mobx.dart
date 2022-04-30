import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'dart:async';
import 'controller/search_controller.dart';

class SearchPageWithMobx extends StatefulWidget {
  const SearchPageWithMobx({Key? key}) : super(key: key);

  @override
  State<SearchPageWithMobx> createState() => _SearchPageWithMobxState();
}

class _SearchPageWithMobxState extends State<SearchPageWithMobx> {
  final _controller = Modular.get<SearchController>();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Search with Mobx'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: TextField(
              onChanged: (text) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 800), () {
                  _controller.searchignText(text);
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Search'),
              ),
            ),
          ),
          Expanded(
            child: Observer(
              builder: (context) => ListView.builder(
                itemCount: _controller.resultSearch.length,
                itemBuilder: (_, id) {
                  final item = _controller.resultSearch[id];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(item.avatarUrl),
                    ),
                    title: Text(item.login),
                    subtitle: Text(item.id.toString()),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
