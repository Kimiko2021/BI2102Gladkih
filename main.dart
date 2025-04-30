import 'package:flutter/material.dart';
import 'classes/machine.dart';
import 'classes/Espresso.dart';
import 'classes/Latte.dart';
import 'classes/Cappuccino.dart';

void main() => runApp(CoffeeApp());

class CoffeeApp extends StatefulWidget {
  @override
  _CoffeeAppState createState() => _CoffeeAppState();
}

class _CoffeeAppState extends State<CoffeeApp> {
  final Machine _machine = Machine();
  String _message = 'Добро пожаловать!';

  void _makeCoffee(String type) {
    setState(() {
      switch (type) {
        case 'эспрессо':
          _message = _machine.makeCoffee(Espresso());
          break;
        case 'латте':
          _message = _machine.makeCoffee(Latte());
          break;
        case 'капучино':
          _message = _machine.makeCoffee(Cappuccino());
          break;
      }
    });
  }

  void _refillResources() {
    setState(() {
      _machine.refill(beans: 200, milk: 200, water: 500);
      _message = 'Ресурсы пополнены!';
    });
  }

  void _withdrawCash() {
    setState(() {
      int cash = _machine.withdrawCash();
      _message = 'Инкассация: $cash ₽';
    });
  }

  void _showStatus() {
    setState(() {
      _message = _machine.status();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофемашина',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Кофемашина'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                _message,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
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
                  ElevatedButton(
                    onPressed: _refillResources,
                    child: Text('Пополнить ресурсы'),
                  ),
                  ElevatedButton(
                    onPressed: _withdrawCash,
                    child: Text('Забрать деньги'),
                  ),
                  ElevatedButton(
                    onPressed: _showStatus,
                    child: Text('Показать статус'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
