import 'packagefluttermaterial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title 'Increment App',
      theme ThemeData(
        primarySwatch Colors.blue,  Цветовая тема приложения
      ),
      home MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() = _MyHomePageState();
}

class _MyHomePageState extends StateMyHomePage {
  int _counter = 0;  Инициализация счетчика

   Функция для увеличения счетчика
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

   Функция для уменьшения счетчика
  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

   Функция для сброса счетчика
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar AppBar(
        title Text('Инкремент'),  Заголовок приложения
      ),
      body Center(
        child Column(
          mainAxisAlignment MainAxisAlignment.center,
          children Widget[
            Text(
              'Значение инкремента',
              style TextStyle(fontSize 20),
            ),
            Text(
              '$_counter',  Показывает значение счетчика
              style TextStyle(fontSize 50),
            ),
            SizedBox(height 20),  Отступ между элементами
            Row(
              mainAxisAlignment MainAxisAlignment.center,
              children Widget[
                 Кнопка с минусом (красная)
                Container(
                  decoration BoxDecoration(
                    color Colors.red,  Красный фон
                    borderRadius BorderRadius.circular(10),  Закругление углов
                  ),
                  child IconButton(
                    icon Icon(Icons.remove, color Colors.white),  Белая иконка минуса
                    onPressed _decrementCounter,  Уменьшить счетчик
                  ),
                ),
                SizedBox(width 20),  Отступ между кнопками
                 Кнопка с плюсом (зелёная)
                Container(
                  decoration BoxDecoration(
                    color Colors.green,  Зелёный фон
                    borderRadius BorderRadius.circular(10),  Закругление углов
                  ),
                  child IconButton(
                    icon Icon(Icons.add, color Colors.white),  Белая иконка плюса
                    onPressed _incrementCounter,  Увеличить счетчик
                  ),
                ),
              ],
            ),
            SizedBox(height 20),  Отступ между кнопками
            TextButton(
              style TextButton.styleFrom(
                backgroundColor Colors.grey,  Цвет фона кнопки
              ),
              onPressed _resetCounter,  Сбросить счетчик
              child Text(
                'Сбросить',
                style TextStyle(color Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
