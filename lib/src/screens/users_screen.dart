import 'package:flutter/material.dart';
import 'package:jsonplaceholder/src/providers/api_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class UsersScreen extends StatelessWidget {
   
  const UsersScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
      final service = Provider.of<ApiProvider>(context);
          
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Users')),
         actions: [
          IconButton(
            onPressed: (){

            },
             icon: const Icon(Icons.logout)
             )
        ],
      ),
      
      body:
      service.isLoading?
      const Center(
        child: CircularProgressIndicator(color: Colors.deepPurple),
      )

      :
      
      
       Container(
        child: ListView.builder(
          itemCount: service.users.length,
          itemBuilder: (_, int index) => UsersCard(user: service.users[index]))
        ),
      
      
    );
  }
}