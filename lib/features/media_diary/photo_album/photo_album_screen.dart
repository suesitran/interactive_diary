import 'package:flutter/material.dart';

class PhotoAlbumScreen extends StatelessWidget {
  const PhotoAlbumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Photo Album'),
        ),
        body: const Center(
          child: Text('Dummy screen'),
        ),
      );
}
