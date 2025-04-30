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
  String _message = '';
  double _moneyEntered = 0.0;
  double _change = 0.0;

  // Для пополнения ресурсов
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _coffeeBeansController = TextEditingController();
  final TextEditingController _milkController = TextEditingController();

  // Для обработки заказа
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

  // Проверка наличных средств для оплаты
  void _processPayment(double price) {
    if (_moneyEntered < price) {
      setState(() {
        _message = 'Недостаточно средств для оплаты.';
        _change = 0.0;
      });
    } else if (_moneyEntered < 0) {
      setState(() {
        _message = 'Сумма не может быть отрицательной.';
        _change = 0.0;
      });
    } else {
      setState(() {
        _change = _moneyEntered - price;
        _message = 'Кофе готовится. Сдача: $_change руб.';
      });
    }
  }

  // Обработка пополнения ресурсов
  void _refillResources() {
    double water = double.tryParse(_waterController.text) ?? 0;
    double coffeeBeans = double.tryParse(_coffeeBeansController.text) ?? 0;
    double milk = double.tryParse(_milkController.text) ?? 0;

    if (water < 0 || coffeeBeans < 0 || milk < 0) {
      setState(() {
        _message = 'Значения не могут быть отрицательными.';
      });
    } else if (water == 0 && coffeeBeans == 0 && milk == 0) {
      setState(() {
        _message = 'Введите значения для пополнения.';
      });
    } else {
      setState(() {
        _machine.water += water;
        _machine.coffeeBeans += coffeeBeans;
        _machine.milk += milk;
        _message = 'Ресурсы пополнены!';
      });
    }
  }

  // Обнуление кассы
  void _resetCash() {
    setState(() {
      _moneyEntered = 0.0;
      _change = 0.0;
      _message = 'Касса обнулена';
    });
  }

  // Вкладка 1: Работа с кофе и деньгами
  Widget _coffeeTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        SizedBox(height: 20),
        Text('Введите сумму для оплаты:'),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Сумма',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _moneyEntered = double.tryParse(value) ?? 0.0;
            });
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (_moneyEntered > 0) {
              _processPayment(150); // Предположим, кофе стоит 150 руб
            } else {
              setState(() {
                _message = 'Введите корректную сумму для оплаты';
              });
            }
          },
          child: Text('Оплатить'),
        ),
        SizedBox(height: 20),
        Text('Сдача: $_change руб.'),
      ],
    );
  }

  // Вкладка 2: Управление ресурсами
  Widget _resourcesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(_message, style: TextStyle(fontSize: 18)),
        SizedBox(height: 20),
        Text('Ресурсы на данный момент:'),
        SizedBox(height: 10),
        Text('Вода: ${_machine.water} мл'),
        Text('Кофе: ${_machine.coffeeBeans} г'),
        Text('Молоко: ${_machine.milk} мл'),
        SizedBox(height: 20),
        TextField(
          controller: _waterController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Пополнить воду (мл)',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _coffeeBeansController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Пополнить кофе (г)',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _milkController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Пополнить молоко (мл)',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _refillResources,
          child: Text('Пополнить ресурсы'),
        ),
        SizedBox(height: 20),
        // Текущий счет кассы
        Text('Касса: $_moneyEntered руб.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _resetCash,
          child: Text('Обнулить кассу'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Кофемашина'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Кофе и оплата',),
                Tab(text: 'Ресурсы',),
              ],
              labelColor: Colors.black,  // Черный цвет для названия вкладок
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _coffeeTab(),
                  _resourcesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
