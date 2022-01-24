import 'package:auth_userlist_chat/bloc_observer.dart';
import 'package:auth_userlist_chat/presentation/core/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';

import 'infrastructure/auth/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authRepository = AuthRepository();
  await authRepository.user.first;
  BlocOverrides.runZoned(
    () => runApp(AppWidget(authRepository: authRepository)),
    blocObserver: AppBlocObserver(),
  );
}
