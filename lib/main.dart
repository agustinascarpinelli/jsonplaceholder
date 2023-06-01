import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder/src/bloc/api/api_bloc.dart';
import 'package:jsonplaceholder/src/providers/providers.dart';
import 'package:jsonplaceholder/src/screens/screens.dart';
import 'package:jsonplaceholder/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

void main(){
 runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiProvider()),
        ChangeNotifierProvider(create: (_) => FormProvider()),
        BlocProvider(create: (_)=>ApiBloc())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (_) => const LoginScreen(),
        'home': (_) => const HomeScreen(),
        'users': (_) => const UsersScreen(),
        'posts': (_) => const PostsScreen(),
        'createPost': (_) => const CreatePostScreen(),
      },
      scaffoldMessengerKey: Notifications.messengerKey,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.deepPurple.shade100,
        colorScheme: const ColorScheme.light(primary: Colors.deepPurple),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
      ),
    );
  }
}
