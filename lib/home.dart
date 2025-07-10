
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child:IconButton(onPressed: (){}, icon: Icon(Icons.video_camera_back, size: 50)),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow, size: 50)),
            ),
          ],),
        ),
      ),
    );
  }
}