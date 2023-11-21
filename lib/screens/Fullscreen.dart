import 'package:flutter/material.dart';

class FullScreen extends StatefulWidget {
  final String imageurl;
  const FullScreen({super.key, required this.imageurl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: Image.network(
            widget.imageurl,
            fit: BoxFit.cover,
          )),
          Container(
            color: Colors.white,
            height: 30,
            width: double.infinity,
            child: const Center(
              child: Text(
                "Set As Wallpaper",
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
