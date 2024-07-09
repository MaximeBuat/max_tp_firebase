import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:max_tp_firebase/models/post.dart';
import 'package:max_tp_firebase/post_screen/add_post_bloc/add_post_bloc.dart';

class ModifPostScreen extends StatefulWidget {
  final Post post;

  const ModifPostScreen({super.key, required this.post});

  @override
  State<ModifPostScreen> createState() => _ModifPostScreenState();
}

class _ModifPostScreenState extends State<ModifPostScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.post.title);
    _descriptionController =
        TextEditingController(text: widget.post.description);
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
        title: const Text('Modify Post'),
      ),
      body: BlocConsumer<AddPostBloc, AddPostState>(
        listener: _onModifPostListener,
        builder: (context, state) {
          if (state.status == AddPostStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.read<AddPostBloc>().add(
                          UpdatePost(
                            Post(
                              id: widget.post.id,
                              title: _titleController.text,
                              description: _descriptionController.text,
                            ),
                          ),
                        );
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onModifPostListener(BuildContext context, AddPostState state) async {
    if (state.status == AddPostStatus.success) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post modified successfully'),
        ),
      );
    } else if (state.status == AddPostStatus.error) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error!),
        ),
      );
    }
  }
}
