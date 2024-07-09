import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:max_tp_firebase/firebase_options.dart';
import 'package:max_tp_firebase/models/post_repository.dart';
import 'package:max_tp_firebase/post_screen/list_post_screen.dart';
import 'package:max_tp_firebase/post_screen/post_bloc/post_bloc.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ListPostScreen();
      },
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(
        FirestorePostRepository(),
      ),
      child: MaterialApp.router(
        routerConfig: _router,
      )
    );
  }
}