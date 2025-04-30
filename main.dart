import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lists',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListsHome(),
    );
  }
}

class ListsHome extends StatelessWidget {
  const ListsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Списки'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Обычный список'),
              Tab(text: 'Бесконечный список'),
              Tab(text: 'Математический список'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SimpleList(),
            InfiniteList(),
            InfiniteMathList(),
          ],
        ),
      ),
    );
  }
}

// Простой список
class SimpleList extends StatelessWidget {
  const SimpleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Text('1'),
        Divider(),
        Text('2'),
        Divider(),
        Text('3'),
      ],
    );
  }
}

// Бесконечный список со строками
class InfiniteList extends StatelessWidget {
  const InfiniteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: null, // Бесконечный список
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text('${index + 1}'),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}

// Бесконечный список с возведением числа 2 в степень
class InfiniteMathList extends StatelessWidget {
  const InfiniteMathList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: null, // Бесконечный список
      itemBuilder: (context, index) {
        BigInt value = BigInt.from(2).pow(index + 1); // Вычисление 2^N
        return Column(
          children: [
            ListTile(
              title: Text('2^${index + 1} = $value'),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
