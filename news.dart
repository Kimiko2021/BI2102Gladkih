import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Класс для обхода проверки сертификатов
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

Future<List<Item>> fetchItems(http.Client client) async {
  try {
    final response = await client.get(Uri.parse(
        'https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90'));
    if (response.statusCode == 200) {
      return compute(parseItems, response.body);
    } else {
      throw Exception('Ошибка сервера: ${response.statusCode}');
    }
  } catch (e) {
    print('Ошибка при загрузке данных: $e');
    rethrow;
  }
}

List<Item> parseItems(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Item>((json) => Item.fromJson(json)).toList();
}

class Item {
  final String id;
  final String activeFrom;
  final String title;
  final String previewText;
  final String previewPictureSrc;
  final String detailPageUrl;
  final String detailText;
  final String lastModified;

  const Item({
    required this.id,
    required this.activeFrom,
    required this.title,
    required this.previewText,
    required this.previewPictureSrc,
    required this.detailPageUrl,
    required this.detailText,
    required this.lastModified,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['ID'] as String? ?? '',
      activeFrom: json['ACTIVE_FROM'] as String? ?? '',
      title: Bidi.stripHtmlIfNeeded(json['TITLE'] as String? ?? ''),
      previewText: Bidi.stripHtmlIfNeeded(json['PREVIEW_TEXT'] as String? ?? ''),
      previewPictureSrc: json['PREVIEW_PICTURE_SRC'] as String? ?? '',
      detailPageUrl: json['DETAIL_PAGE_URL'] as String? ?? '',
      detailText: Bidi.stripHtmlIfNeeded(json['DETAIL_TEXT'] as String? ?? ''),
      lastModified: json['LAST_MODIFIED'] as String? ?? '',
    );
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides(); // Настройка для Android
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лента новостей КубГАУ',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.green[50],
        cardTheme: CardTheme(
          elevation: 4,
          margin: EdgeInsets.all(8),
          color: Colors.white,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лента новостей КубГАУ'),
        backgroundColor: Colors.green[700],
      ),
      body: FutureBuilder<List<Item>>(
        future: fetchItems(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Ошибка: ${snapshot.error}');
            return Center(
              child: Text('Ошибка загрузки данных: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ItemsList(items: snapshot.data!);
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

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key, required this.items}) : super(key: key);
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(item: items[index]),
              ),
            );
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (items[index].previewPictureSrc.isNotEmpty)
                  Image.network(
                    items[index].previewPictureSrc,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items[index].title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index].previewText,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  final Item item;

  const DetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.previewPictureSrc.isNotEmpty)
                Image.network(
                  item.previewPictureSrc,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),
              Text(
                'Дата: ${item.activeFrom}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.detailText,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Последнее изменение: ${item.lastModified}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
