import 'package:flutter/material.dart';
import 'package:jsonplaceholder/src/models/users_model.dart';

class UsersCard extends StatelessWidget {
  final UsersResponse user;
  const UsersCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.all(20),
        width: 200,
        height: 210,
        padding:const EdgeInsets.only(left:20,top: 20,bottom: 20 ),
        decoration: _UsersCardDecoration(),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
      
          children: [
            RichText(
              text: TextSpan(
                text: 'Name :',
                style: propertiesStyle(),
                children: [
                  TextSpan(
                    text:' ${user.name}',
                     style:propertiesStyles2(),
                  )
                ]
              )),
                   RichText(
              text: TextSpan(
                text: 'Username :',
                style: propertiesStyle(),
                children: [
                  TextSpan(
                    text:' ${user.username}',
                     style:propertiesStyles2(),
                  )
                ]
              )),
                   RichText(
              text: TextSpan(
                text: 'Email :',
                style: propertiesStyle(),
                children: [
                  TextSpan(
                    text:' ${user.email}',
                     style:propertiesStyles2(),
                  )
                ]
              )),
                   RichText(
              text: TextSpan(
                text: 'Address :',
                style: propertiesStyle(),
                children: [
                  TextSpan(
                    text:' ${user.address.street}',
                     style:propertiesStyles2(),
                  )
                ]
              )),
                   RichText(
              text: TextSpan(
                text: 'Phone :',
                style: propertiesStyle(),
                children: [
                  TextSpan(
                    text:' ${user.phone}',
                     style:propertiesStyles2(),
                  )
                ]
              )),
                   RichText(
              text: TextSpan(
                text: 'Website :',
                style: propertiesStyle(),
                children: [
                  TextSpan(
                    text:' ${user.website}',
                     style:propertiesStyles2(),
                  )
                ]
              )),
                   RichText(
              text: TextSpan(
                text: 'Company :',
                style: propertiesStyle(),
                children: [
                  TextSpan(
                    text:' ${user.company.name}',
                     style:propertiesStyles2(),
                  )
                ]
              )),
           
     
          ],
        ),
      ),
    );
  }

  TextStyle propertiesStyles2() => const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    
    color:Colors.black
    

  );

  TextStyle propertiesStyle() => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.deepPurple

  );

  BoxDecoration _UsersCardDecoration() => BoxDecoration(
    color:Colors.white,
    shape: BoxShape.rectangle,
    boxShadow: [
      BoxShadow(
        color: Colors.deepPurple.shade50,
        blurRadius: 10.0,
        offset: Offset(0.0,10.0),
      )
    ],
    borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
    
      colors:[
        Colors.deepPurple.shade300,
        Colors.deepPurple.shade100
      ] )
  );
}
