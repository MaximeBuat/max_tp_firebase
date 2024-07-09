import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:max_tp_firebase/models/post.dart';
import 'package:max_tp_firebase/post_screen/add_post_bloc/add_post_bloc.dart'; // Add this line

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add post'),
      ),
      body: BlocConsumer<AddPostBloc, AddPostState>(
        listener: _onAddPostListener,
        builder: (context, state) {
          if (state.status == AddPostStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<AddPostBloc>().add(
                          AddPost(
                            Post(
                              title: _titleController.text,
                              description: _descriptionController.text,
                            ),
                          ),
                        );
                  },
                  child: const Text('Add post'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onAddPostListener(BuildContext context, AddPostState state) async {
    if (state.status == AddPostStatus.success) {
      Navigator.of(context).pop();
    } else if (state.status == AddPostStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error!),
        ),
      );
    }
  }
}
