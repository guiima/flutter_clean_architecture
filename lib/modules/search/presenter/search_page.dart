import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/modules/search/presenter/search/search_bloc.dart';
import 'package:flutter_clean_architecture/modules/search/presenter/search/state/search_event.dart';
import 'package:flutter_clean_architecture/modules/search/presenter/search/state/search_state.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'dart:async';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchBloc _bloc = Modular.get<SearchBloc>();
  Timer? _debounce;

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: TextField(
              onChanged: (text) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 800), () {
                  _bloc.add(SearchignText(text));
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Search'),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<SearchState>(
                stream: _bloc.stream,
                builder: (context, snapshot) {
                  final state = _bloc.state;

                  if (state is SearchStart) {
                    return const Center(
                      child: Text('Digite um texto'),
                    );
                  }

                  if (state is SearchEror) {
                    return const Center(
                      child: Text('Houve um erro'),
                    );
                  }

                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final list = (state as SearchSuccess).list;

                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, id) {
                      final item = list[id];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(item.avatarUrl),
                        ),
                        title: Text(item.login),
                        subtitle: Text(item.id.toString()),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
