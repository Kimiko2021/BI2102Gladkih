import 'package:flutter/material.dart';
import 'classes/machine.dart';
import 'classes/Espresso.dart';
import 'classes/Latte.dart';
import 'classes/Cappuccino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофемашина',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CoffeeHomePage(),
    );
  }
}

class CoffeeHomePage extends StatefulWidget {
  @override
  _CoffeeHomePageState createState() => _CoffeeHomePageState();
}

class _CoffeeHomePageState extends State<CoffeeHomePage> {
  final Machine _machine = Machine();
  String _message = 'Выберите кофе';

  void _makeCoffee(String type) async {
    String result;
    switch (type) {
      case 'эспрессо':
        result = await _machine.makeCoffee(Espresso());
        break;
      case 'латте':
        result = await _machine.makeCoffee(Latte());
        break;
      case 'капучино':
        result = await _machine.makeCoffee(Cappuccino());
        break;
      default:
        result = 'Неизвестный выбор';
    }

    setState(() {
      _message = result;
    });
  }

  void _refillResources() {
    setState(() {
      _machine.coffeeBeans += 500;
      _machine.milk += 1000;
      _machine.water += 1000;
      _message = 'Ресурсы пополнены!';
    });
  }

  void _resetCash() {
    setState(() {
      _machine.resetCash();
      _message = 'Касса обнулена.';
    });
  }

  void _showStatus() {
    setState(() {
      _message =
          'Состояние:\nКофе: ${_machine.coffeeBeans} г\nМолоко: ${_machine.milk} мл\nВода: ${_machine.water} мл\nКасса: ${_machine.cash} руб.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Кофемашина'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(_message, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => _makeCoffee('эспрессо'),
                  child: Text('Эспрессо'),
                ),
                ElevatedButton(
                  onPressed: () => _makeCoffee('латте'),
                  child: Text('Латте'),
                ),
                ElevatedButton(
                  onPressed: () => _makeCoffee('капучино'),
                  child: Text('Капучино'),
                ),
              ],
            ),
            SizedBox(height: 30),
            Wrap(
              spacing: 10,
              children: [
                OutlinedButton(
                  onPressed: _refillResources,
                  child: Text('Пополнить ресурсы'),
                ),
                OutlinedButton(
                  onPressed: _resetCash,
                  child: Text('Обнулить кассу'),
                ),
                OutlinedButton(
                  onPressed: _showStatus,
                  child: Text('Показать статус'),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text('Остатки ресурсов:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Кофе: ${_machine.coffeeBeans} г'),
            Text('Молоко: ${_machine.milk} мл'),
            Text('Вода: ${_machine.water} мл'),
            Text('Касса: ${_machine.cash} руб.'),
          ],
        ),
      ),
    );
  }
}
