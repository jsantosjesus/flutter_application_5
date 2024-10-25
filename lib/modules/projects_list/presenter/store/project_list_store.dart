import 'package:flutter/material.dart';
import 'package:flutter_application_5/errors/error.dart';
import 'package:flutter_application_5/modules/projects_list/models/project_model.dart';
import 'package:flutter_application_5/modules/projects_list/repository/projects_list_repository.dart';

class ProjectListStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  final ValueNotifier<List<ProjectModel>> success =
      ValueNotifier<List<ProjectModel>>([]);

  final IProjectListRepository repository;

  ProjectListStore({required this.repository});

  Future getProjectStore({required String userName}) async {
    try {
      final result = await repository.getProjects(userName: userName);
      success.value = result;
    } on RepositoryError catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
