import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:max_tp_firebase/post_screen/post_bloc/post_bloc.dart';

class ListPostScreen extends StatefulWidget {
  const ListPostScreen({super.key});

  @override
  State<ListPostScreen> createState() => _ListPostScreenState();
}

class _ListPostScreenState extends State<ListPostScreen> {
  @override
  void initState() {
    super.initState();
    _getAllPosts();
  }

  void _getAllPosts() async {
    final productsBloc = BlocProvider.of<PostBloc>(context);
    productsBloc.add(LoadPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PostStatus.success:
              if (state.posts.isEmpty) {
                return const Center(child: Text('No posts'));
              }
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.description),
                    onTap: () {
                      GoRouter.of(context).go('/modif_post', extra: post);
                    },
                  );
                },
              );
            case PostStatus.error:
              return Center(child: Text(state.error!));
            case PostStatus.empty:
              return const Center(child: Text('No posts'));
            default:
              return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'error',
            onPressed: () {
              throw Exception('Intentional error for testing purposes');
            },
            child: const Icon(Icons.bug_report),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              GoRouter.of(context).go('/add_post');
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );

  }
}
