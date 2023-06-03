import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:jsonplaceholder/src/bloc/blocs.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = BlocProvider.of<AuthBloc>(context);
    
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Users'),
          actions: [
            IconButton(
                onPressed: () {
                  auth.add(Logout());
                  Navigator.pushReplacementNamed(context, 'login');
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body:
            BlocBuilder<ServicesBloc, ServicesState>(builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
          } else if (state.error != null) {
            final String error = state.error!;
            return Notifications.showSnackBar(error);
          } else if(state.users!=null) {
            return ListView.builder(
                itemCount: state.users!.length,
                itemBuilder: (_, int index) =>
                    UsersCard(user: state.users![index]));
          }
          return const SizedBox(child: Center(child: Text('Error in conexion.Try again later'),),);
        }));
  }
}
