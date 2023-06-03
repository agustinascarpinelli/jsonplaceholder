import 'package:flutter/material.dart';
import 'package:jsonplaceholder/src/models/models.dart';

class PostsCard extends StatelessWidget {
  final PostResponse post;
  const PostsCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        width: 100,
        decoration: postCardDecoration(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: 'Title :',
                      style: propertiesStyle(),
                      children: [
                    TextSpan(
                      text: ' ${post.title}',
                      style: propertiesStyles2(),
                    )
                  ])),
              RichText(
                  text: TextSpan(
                      text: 'Body :',
                      style: propertiesStyle(),
                      children: [
                    TextSpan(
                      text: ' ${post.body}',
                      style: propertiesStyles2(),
                    )
                  ])),
            ]),
      ),
    );
  }

  BoxDecoration postCardDecoration() => BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.shade50,
          blurRadius: 10.0,
          offset: const Offset(0.0, 10.0),
        )
      ],
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade100]));

  TextStyle propertiesStyles2() => const TextStyle(
      fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black);

  TextStyle propertiesStyle() => const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple);
}
