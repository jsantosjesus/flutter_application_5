import 'package:dio/dio.dart';
import 'package:flutter_application_5/errors/error.dart';
import 'package:flutter_application_5/modules/search_user/models/user_model.dart';
import 'package:flutter_application_5/request/json_request.dart';

abstract class ISearchUserRepository {
  Future<List<UserModel>> getUsers({required String searchText});
}

class SearchUserRepositoryImpl implements ISearchUserRepository {
  final IJsonRequest request;

  SearchUserRepositoryImpl({required this.request});
  @override
  Future<List<UserModel>> getUsers({required String searchText}) async {
    final Response response = await request.get(
        url: 'https://api.github.com/search/users?q=$searchText');

    if (response.statusCode == 200 && response.data != null) {
      final List<UserModel> userList = [];
      response.data['items'].map((item) {
        userList.add(UserModel.fromMap(item));
      }).toList();

      return userList;
    } else {
      throw RepositoryError(message: 'Erro ao fazer requisição');
    }
  }
}
