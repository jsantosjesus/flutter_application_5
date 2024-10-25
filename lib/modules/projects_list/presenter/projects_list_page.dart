import 'package:flutter/material.dart';
import 'package:flutter_application_5/modules/projects_list/presenter/store/project_list_store.dart';
import 'package:flutter_application_5/modules/projects_list/repository/projects_list_repository.dart';
import 'package:flutter_application_5/request/json_request.dart';
import 'package:go_router/go_router.dart';

class ProjectsListPage extends StatefulWidget {
  final String userName;
  const ProjectsListPage({super.key, required this.userName});

  @override
  State<ProjectsListPage> createState() => _ProjectsListPageState();
}

class _ProjectsListPageState extends State<ProjectsListPage> {
  final ProjectListStore store = ProjectListStore(
      repository: ProjectListRepositoryImpl(request: DioRequest()));

  @override
  void initState() {
    super.initState();

    store.getProjectStore(userName: widget.userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.userName),
        ),
        body: AnimatedBuilder(
            animation: Listenable.merge([
              store.isLoading,
              store.error,
              store.success,
            ]),
            builder: (_, id) {
              if (store.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (store.error.value.isNotEmpty) {
                return Center(
                  child: Text(store.error.value),
                );
              } else if (store.success.value.isEmpty) {
                return const Center(
                  child: Text('Este usuário não possui repositório público'),
                );
              } else {
                return ListView.builder(
                    itemCount: store.success.value.length,
                    itemBuilder: (_, id) {
                      final item = store.success.value[id];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(item.name[0]),
                        ),
                        title: Text(item.name),
                        onTap: () {
                          final String userName = widget.userName;
                          final String projectName = item.name;
                          context.push('/webview/$userName/$projectName');
                        },
                      );
                    });
              }
            }));
  }
}
