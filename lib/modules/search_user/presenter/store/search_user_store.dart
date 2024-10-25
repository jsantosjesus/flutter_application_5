import 'package:flutter/material.dart';
import 'package:flutter_application_5/errors/error.dart';
import 'package:flutter_application_5/modules/search_user/models/user_model.dart';
import 'package:flutter_application_5/modules/search_user/repository/search_user_repository.dart';

class SearchUserStore {
  final ValueNotifier<bool> initialState = ValueNotifier<bool>(true);

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  final ValueNotifier<List<UserModel>> success =
      ValueNotifier<List<UserModel>>([]);

  final ISearchUserRepository repository;

  String lastSearch = '';

  SearchUserStore({required this.repository});

  Future getUserStore({required String searchText}) async {
    if (lastSearch == searchText) {
      return;
    } else if (searchText.isNotEmpty && searchText[0] != ' ') {
      initialState.value = false;
      isLoading.value = true;
      lastSearch = searchText;

      try {
        final result = await repository.getUsers(searchText: searchText);

        error.value = '';
        success.value = result;
      } on RepositoryError catch (e) {
        error.value = e.message;
      } catch (e) {
        error.value = e.toString();
      }
    } else {
      error.value = 'Digite pelo menos uma letra';
    }

    isLoading.value = false;
  }
}
