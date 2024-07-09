import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:max_tp_firebase/firebase_options.dart';
import 'package:max_tp_firebase/models/post.dart';
import 'package:max_tp_firebase/models/post_repository.dart';
import 'package:max_tp_firebase/post_screen/add_post_bloc/add_post_bloc.dart';
import 'package:max_tp_firebase/post_screen/add_post_screen.dart';
import 'package:max_tp_firebase/post_screen/list_post_screen.dart';
import 'package:max_tp_firebase/post_screen/modif_post_screen.dart';
import 'package:max_tp_firebase/post_screen/post_bloc/post_bloc.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ListPostScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'add_post',
          builder: (BuildContext context, GoRouterState state) {
            return const AddPostScreen();
          },
        ),
        GoRoute(
          path: 'modif_post',
          builder: (BuildContext context, GoRouterState state) {
            final post = state.extra as Post;
            return ModifPostScreen(post: post);
          },
        ),
      ],
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
// Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostBloc(
            FirestorePostRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => AddPostBloc(
            FirestorePostRepository(),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
      ),
    );
  }
}
