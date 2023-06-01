import 'package:flutter/material.dart';
import 'package:jsonplaceholder/src/providers/providers.dart';
import 'package:provider/provider.dart';
import '../providers/api_provider.dart';
import '../providers/providers.dart';
import '../ui/form_ui.dart';
import '../widgets/widgets.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new post'),
      ),
      body: Center(
          child: Container(
        width: 800,
        height: 800,
        margin: const EdgeInsets.all(40),
        // ignore: prefer_const_literals_to_create_immutables
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          const _Form()
        ]),
      )),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key? key,
  }) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postForm = Provider.of<FormProvider>(context);
   
    return Form(
        key: postForm.postKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              autocorrect: false,
              decoration: FormDecoration.loginInput(
                hintText: 'Add a title',
                labelText: 'Title',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: bodyController,
              autocorrect: false,
              maxLines: 3,
              maxLength: 100,
              decoration: FormDecoration.loginInput(
                hintText: 'Add a description',
                labelText: 'Description',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              disabledColor: Colors.deepPurple.shade300,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: postForm.isLoading
                  ? null
                  : () async {
           
                      FocusScope.of(context).unfocus();
                      final service =
                          Provider.of<ApiProvider>(context, listen: false);

                      if (!postForm.isValidForm()) return;
                      postForm.isLoading = true;
                      final String title = titleController.text;
                      final String body = bodyController.text;

                      await service.createPost(title, body);
                      postForm.isLoading = false;
                      if (service.isCreated) {
                        // ignore: use_build_context_synchronously
                        Notifications.showSnackBar('Post created');
                        service.isCreated = false;
                        
                        Navigator.pop(context);

                      } else {
                        Notifications.showSnackBar(
                            'Error posting, try again later');
                        postForm.isLoading = false;
                      }
                    },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(postForm.isLoading ? 'Loading' : 'Create',
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ));
  }
}
