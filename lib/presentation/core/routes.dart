import 'package:auth_userlist_chat/presentation/auth/sign_in/sign_in_page.dart';
import 'package:auth_userlist_chat/presentation/users/user_list/users_page.dart';
import 'package:auth_userlist_chat/application/auth/auth_bloc.dart';
import 'package:flutter/widgets.dart';

List<Page> onGenerateAppViewPages(AuthStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AuthStatus.authenticated:
      return [UserListPage.page()];
    case AuthStatus.unauthenticated:
    default:
      return [SignInPage.page()];
  }
}
