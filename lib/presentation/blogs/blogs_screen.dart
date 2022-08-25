import 'package:flutter/material.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.black),
      body: Center(
        child: Text("blogs"),
      ),
    );
  }
}
