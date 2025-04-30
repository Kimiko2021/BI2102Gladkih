import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(Uri.parse('https://boringapi.com/api/v1/photos/'));

  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    if (decoded['success'] == true) {
      return compute(parsePhotos, response.body);
    } else {
      throw Exception('API выдало success: false');
    }
  } else {
    throw Exception('фотографии не загружены: ${response.statusCode}');
  }
}

List<Photo> parsePhotos(String responseBody) {
  final decoded = jsonDecode(responseBody);
  final photosJson = decoded['photos'] as List<dynamic>;
  return photosJson.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final int id;
  final String description;
  final String title;
  final int file_size;
  final int height;
  final String updated_at;
  final int width;
  final String created_at;
  final String url;

  const Photo({
    required this.id,
    required this.description,
    required this.title,
    required this.file_size,
    required this.height,
    required this.updated_at,
    required this.width,
    required this.created_at,
    required this.url,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int,
      description: json['description'] as String,
      title: json['title'] as String,
      file_size: json['file_size'] as int,
      height: json['height'] as int,
      updated_at: json['updated_at'] as String,
      width: json['width'] as int,
      created_at: json['created_at'] as String,
      url: json['url'] as String,
    );
  }
}

void main() => runApp(const galery());

class galery extends StatelessWidget {
  const galery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Фотогалерея';
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Ошибка: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({Key? key, required this.photos}) : super(key: key);
  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].url);
      },
    );
  }
}
