import 'ICoffee.dart';
import 'resources.dart';

class Cappuccino implements ICoffee {
  @override
  Resources get resources => Resources(coffeeBeans: 50, milk: 50, water: 100);

  @override
  int get price => 130;

  @override
  String get name => 'Капучино';
}
