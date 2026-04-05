import 'package:flutter/material.dart';
import 'package:pizza_app/features/screens/home/widgets/build_crust_type_group.dart';
import 'package:pizza_app/features/screens/home/widgets/build_size_group.dart';
import 'package:pizza_app/features/screens/home/widgets/build_where_eat_group.dart';

class PizzaProvider with ChangeNotifier {
  PizzaSize _selectedSize = PizzaSize.medium;

  CrustType _selectedCrust = CrustType.thin;

  WhereToEat _selectedWhereToEat = WhereToEat.dineIn;
  bool _isEnabled = false;

  String _notes = "";

  final Map<String, bool> _toppingsList = {
    "Extra Cheese": false,
    "Onion": false,
    "Mushrooms": false,
    "Olives": false,
    "Tomatoes": false,
    "Green Peppers": false,
  };

  final Map<PizzaSize, double> _sizePrices = {
    PizzaSize.small: 10.0,
    PizzaSize.medium: 20.0,
    PizzaSize.large: 30.0,
  };
  final Map<String, double> _toppingPrices = {
    "Extra Cheese": 2.0,
    "Onion": 1.0,
    "Mushrooms": 1.5,
    "Olives": 1.0,
    "Tomatoes": 1.0,
    "Green Peppers": 1.0,
  };
  final Map<CrustType, double> _crustPrices = {
    CrustType.thin: 0.0,
    CrustType.thick: 3.0,
  };

  PizzaSize get selectedSize => _selectedSize;
  CrustType get selectedCrust => _selectedCrust;
  WhereToEat get selectedWhereToEat => _selectedWhereToEat;
  Map<String, bool> get toppings => _toppingsList;
  bool get isEnabled => _isEnabled;
  String get notes => _notes;



  double _calculateTotal() {
    double total = _sizePrices[_selectedSize]! + _crustPrices[_selectedCrust]!;
    _toppingsList.forEach((key, value) {
      if (value) total += _toppingPrices[key]!;
    });
    return total;
  }

  double get calculateTotal {
    return _calculateTotal();
  }

  void setIsEnabled(bool value) {
    _isEnabled = value;
    notifyListeners();
  }

  void setSelectedSize(PizzaSize size) {
    _selectedSize = size;
    notifyListeners();
  }

  void setSelectedCrust(CrustType crust) {
    _selectedCrust = crust;
    notifyListeners();
  }

  void setSelectedWhereToEat(WhereToEat whereToEat) {
    _selectedWhereToEat = whereToEat;
    notifyListeners();
  }

  void setTopping(String topping, bool value) {
    _toppingsList[topping] = value;
    notifyListeners();
  }

  void setNotes(String value) {
  _notes = value;
  notifyListeners(); 
}

  void resetOrder() {
    _isEnabled = false;
    _selectedSize = PizzaSize.medium;
    _selectedCrust = CrustType.thin;
    _selectedWhereToEat = WhereToEat.dineIn;
    _toppingsList.updateAll((key, value) => false);
    _notes = "";
    notifyListeners();
  }
}
