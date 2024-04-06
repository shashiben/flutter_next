import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Column(children: [
        const Text(
          "Avatar Group",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        NextAvatarGroup(
            backgroundColor: Colors.orange,
            imagesList: List.generate(
                6,
                (index) => const NetworkImage(
                    "https://images.ctfassets.net/hrltx12pl8hq/qGOnNvgfJIe2MytFdIcTQ/429dd7e2cb176f93bf9b21a8f89edc77/Images.jpg?fit=fill&w=175&h=175&fm=webp"))),
        const Text(
          "Custom Avatar Group",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        NextAvatarGroup(
          backgroundColor: Colors.orange,
          itemCount: 6,
          widthFactor: 0.8,
          imagesList: List.generate(
              10,
              (index) => const NetworkImage(
                  "https://images.ctfassets.net/hrltx12pl8hq/qGOnNvgfJIe2MytFdIcTQ/429dd7e2cb176f93bf9b21a8f89edc77/Images.jpg?fit=fill&w=175&h=175&fm=webp")),
          itemBuilder: (context, index, image) => Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    image: DecorationImage(image: image),
                    border: Border.all(color: Colors.orange, width: 1.5),
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)),
              ),
              if (index % 3 == 0)
                const Positioned(
                  bottom: 0,
                  left: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 5,
                  ),
                )
            ],
          ),
        ),
        const Text(
          "Avatar Group Limit count",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        NextAvatarGroup(
          backgroundColor: Colors.orange,
          limitTo: 5,
          imagesList: List.generate(
              10,
              (index) => const NetworkImage(
                  "https://images.ctfassets.net/hrltx12pl8hq/qGOnNvgfJIe2MytFdIcTQ/429dd7e2cb176f93bf9b21a8f89edc77/Images.jpg?fit=fill&w=175&h=175&fm=webp")),
          widthFactor: 0.5,
        )
      ]),
    );
  }
}
