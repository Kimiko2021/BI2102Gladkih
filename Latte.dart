import 'ICoffee.dart';
import 'resources.dart';

class Latte implements ICoffee {
  @override
  Resources get resources => Resources(coffeeBeans: 50, milk: 100, water: 100);

  @override
  int get price => 150;

  @override
  String get name => 'Латте';
}
