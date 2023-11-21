import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/screens/fullscreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List images = [];
  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  fetchApi() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
        headers: {
          'Authorization':
              'tR090d5JvFfbiWU5HtI1M8wc9567oVvgXorb2s6eCsK6hFZiS2XoDueY'
        }).then(
      (value) {
        Map result = jsonDecode(value.body);
        setState(() {
          images = result['photos'];
        });
        if (kDebugMode) {
          print(images[0]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Wall-PAPER-E")),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
              child: GridView.builder(
            itemCount: images.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                childAspectRatio: 2 / 3,
                mainAxisSpacing: 2),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        FullScreen(imageurl: images[index]['src']['large2x']),
                  ));
                },
                child: Image.network(
                  images[index]['src']['tiny'],
                  fit: BoxFit.cover,
                ),
              );
            },
          )),
          Container(
            width: double.infinity,
            height: 30,
            color: Colors.white,
            child: const Center(
              child: Text(
                "More",
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
