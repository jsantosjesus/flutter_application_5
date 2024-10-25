import 'package:dio/dio.dart';
import 'package:flutter_application_5/errors/error.dart';
import 'package:flutter_application_5/modules/projects_list/models/project_model.dart';
import 'package:flutter_application_5/request/json_request.dart';

abstract class IProjectListRepository {
  Future<List<ProjectModel>> getProjects({required String userName});
}

class ProjectListRepositoryImpl implements IProjectListRepository {
  final IJsonRequest request;

  ProjectListRepositoryImpl({required this.request});
  @override
  Future<List<ProjectModel>> getProjects({required String userName}) async {
    final Response response =
        await request.get(url: 'https://api.github.com/users/$userName/repos');

    if (response.statusCode == 200 && response.data != null) {
      final List<ProjectModel> projectList = [];
      response.data.map((item) {
        projectList.add(ProjectModel.fromMap(item));
      }).toList();

      return projectList;
    } else {
      throw RepositoryError(message: 'Erro ao fazer requisição');
    }
  }
}
