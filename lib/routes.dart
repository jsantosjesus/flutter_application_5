import 'package:flutter_application_5/modules/projects_list/presenter/projects_list_page.dart';
import 'package:flutter_application_5/modules/search_user/presenter/search_user_page.dart';
import 'package:flutter_application_5/modules/webview_project/presenter/webview_project_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SearchUserPage(),
  ),
  GoRoute(
    path: '/projects/:userName',
    builder: (context, state) => ProjectsListPage(
      userName: state.pathParameters['userName']!,
    ),
  ),
  GoRoute(
    path: '/webview/:userName/:projectName',
    builder: (context, state) => WebViewProjectPage(
      userName: state.pathParameters['userName']!,
      projectName: state.pathParameters['projectName']!,
    ),
  ),
]);
