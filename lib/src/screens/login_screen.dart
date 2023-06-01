import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jsonplaceholder/src/providers/auth_provider.dart';
import 'package:jsonplaceholder/src/ui/form_ui.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text('LOGIN',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 30,
              ),
              const _Form()
            ],
          ),
        ),
      ),
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
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     final loginForm = Provider.of<FormProvider>(context);
    return Form(
        child: Column(
      children: [
        TextFormField(
          controller: usernameController,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: FormDecoration.loginInput(
              hintText: 'email@example.com',
              labelText: 'Email',
              prefixIcon: Icons.person),
          validator: (value) {
            String pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp = RegExp(pattern);
            return regExp.hasMatch(value ?? '')
                ? null
                : 'Please enter a valid email';
          },
        ),
        const SizedBox(height: 30),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          autocorrect: false,
          decoration: FormDecoration.loginInput(
              hintText: '********',
              labelText: 'Password',
              prefixIcon: Icons.key_outlined),
          validator: (value) {
            if (value != null && value.length >= 6) return null;
            return 'Password must be six or more characters';
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
            onPressed: loginForm.isLoading
                  ? null
                  :
                  ()async{
                      FocusScope.of(context).unfocus();
                  //    if (!loginForm.isValidForm()) {
                   //   Notifications.showSnackBar('Not valid email or password');
                  // }
              final i= usernameController.text.indexOf('@');
              final email=usernameController.text.substring(0,i);
              Notifications.showSnackBar('Hello again $email');
              Navigator.pushReplacementNamed(context, 'home');
              loginForm.isLoading = false;
                  },
            child: Text(!loginForm.isLoading ?
              'Log in' :'Loading',
              style: const TextStyle(color: Colors.white),
            )
                
            )
      ],
    ));
  }
}
