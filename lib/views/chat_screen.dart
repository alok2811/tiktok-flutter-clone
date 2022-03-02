import 'package:flutter/material.dart';

import 'message_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  [
           const SizedBox(height: 10,),
            ListTile(
              leading:const CircleAvatar(
                backgroundImage: AssetImage('assets/images/alok.png'),
                radius: 25,
              ),
              title:const Text('Alok Dubey'),
              trailing: const Text("10:47 AM"),
              subtitle: const Text('Hello, World!'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder) => const MessageScreen(name: 'Alok Dubey')));
              },
            ),
           const Divider(),

          ],
        ),
      ),
    );
  }
}
