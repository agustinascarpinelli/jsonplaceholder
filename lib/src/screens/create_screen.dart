import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/blocs.dart';
import '../ui/form_ui.dart';
import '../widgets/widgets.dart';
import 'package:jsonplaceholder/src/providers/providers.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
        final containerWidth = screenWidth > 800 ? 800 : screenWidth;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Create a new post'),
      ),
      body: Center(
          child: SingleChildScrollView(
            child: Container(
                  width: containerWidth.toDouble(),
                  height: 800,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(40),
                  // ignore: prefer_const_literals_to_create_immutables
                  child: const Column(children: [
            SizedBox(
              height: 30,
            ),
            _Form()
                  ]),
                ),
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
    final apiBloc = BlocProvider.of<ApiBloc>(context);
    final serviceBloc = BlocProvider.of<ServicesBloc>(context);
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
                      if (apiBloc.state.isConnected) {
                        FocusScope.of(context).unfocus();

                        if (!postForm.isValidForm()) return;
                        postForm.isLoading = true;
                        final String title = titleController.text;
                        final String body = bodyController.text;

                       serviceBloc.add(CreatePost(title, body));
                        postForm.isLoading = false;
                        if (serviceBloc.state.isCreated) {
                          // ignore: use_build_context_synchronously
                          Notifications.showSnackBar('Post created');
                          serviceBloc.add(OnPostCreated());
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        } else if (serviceBloc.state.errorPost != null) {
                          Notifications.showSnackBar(
                              serviceBloc.state.errorPost!);
                        } else {
                          Notifications.showSnackBar(
                              'Error posting, try again later');
                          postForm.isLoading = false;
                        }
                      } else {
                        Notifications.showSnackBar(
                            'Turn on the conexion to post');
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
