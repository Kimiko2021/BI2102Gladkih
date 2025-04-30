import 'dart:async';

class AsyncProcess {
  static Future<void> heatWater() async {
    print('[Нагрев воды]');
    await Future.delayed(Duration(seconds: 3));
    print('Вода нагрета.');
  }

  static Future<void> brewCoffee() async {
    print('[Заваривание кофе]');
    await Future.delayed(Duration(seconds: 5));
    print('Кофе заварен.');
  }

  static Future<void> frothMilk() async {
    print('[Взбивание молока]');
    await Future.delayed(Duration(seconds: 5));
    print('Молоко взбито.');
  }

  static Future<void> mixCoffeeAndMilk() async {
    print('[Смешивание компонентов]');
    await Future.delayed(Duration(seconds: 3));
    print('Кофе готов!');
  }

  static Future<void> prepareCoffee({required bool needsMilk}) async {
    await heatWater();

    Future coffeeTask = brewCoffee();

    if (needsMilk) {
      await Future.wait([coffeeTask, frothMilk()]);
      await mixCoffeeAndMilk();
    } else {
      await coffeeTask;
      print('Кофе готов!');
    }
  }
}
