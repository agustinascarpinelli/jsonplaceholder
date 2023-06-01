

import 'package:flutter/material.dart';
import 'package:jsonplaceholder/src/widgets/posts_card.dart';
import 'package:provider/provider.dart';

import '../providers/api_provider.dart';

class PostsScreen extends StatelessWidget {
   
  const PostsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
      final service = Provider.of<ApiProvider>(context, listen: true);
    return  Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Posts',style: TextStyle(color:Colors.white),)),
        actions: [
          IconButton(
            onPressed: (){
                Navigator.pushReplacementNamed(context, 'login');
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
       ListView.builder(
         itemCount: service.posts.length,
         itemBuilder: (_, int index) => PostsCard(post: service.posts[index])),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, 'createPost');
        },
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add,color: Colors.white,),
       ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}