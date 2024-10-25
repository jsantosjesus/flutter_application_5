import 'package:flutter/material.dart';
import 'package:flutter_application_5/modules/search_user/presenter/store/search_user_store.dart';
import 'package:flutter_application_5/modules/search_user/repository/search_user_repository.dart';
import 'package:flutter_application_5/request/json_request.dart';
import 'package:go_router/go_router.dart';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({super.key});

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  final SearchUserStore store = SearchUserStore(
      repository: SearchUserRepositoryImpl(request: DioRequest()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pesquisa de usuário'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 8.0, right: 8.0, bottom: 20.0),
            child: TextField(
              onSubmitted: (searchText) {
                store.getUserStore(searchText: searchText);
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                label: Text('pesquise aqui...'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          AnimatedBuilder(
              animation: Listenable.merge([
                store.initialState,
                store.isLoading,
                store.error,
                store.success,
              ]),
              builder: (_, id) {
                if (store.initialState.value) {
                  return const Center(
                    child: Text('sem usuários'),
                  );
                } else if (store.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (store.error.value.isNotEmpty) {
                  return Center(
                    child: Text(store.error.value),
                  );
                } else if (store.success.value.isEmpty) {
                  return const Center(
                    child: Text('Não existe usuário com este login'),
                  );
                } else {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: store.success.value.length,
                          itemBuilder: (_, id) {
                            final item = store.success.value[id];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(item.img),
                              ),
                              title: Text(item.name),
                              onTap: () {
                                final String userName = item.name;
                                context.push('/projects/$userName');
                              },
                            );
                          }));
                }
              })
        ],
      ),
    );
  }
}
