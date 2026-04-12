import 'package:flutter/material.dart';
import 'package:learn_widgets/core/constans.dart';

class DropDownProvider with ChangeNotifier {
  String _selectedImage = imBoy;

  final Map<String, String> _dropDownData = {
    imBoy: 'Boy',
    imGirl: 'Girl',
    imBook: 'Book',
    imPencil: 'Pencil',
  };

  String get selectedImage => _selectedImage;

  String get imageTitle => _dropDownData[_selectedImage] ?? 'Unknown';

  Map<String, String> get dropDownData => _dropDownData;

  void setSelectedImage(String? newValue) {
    if (newValue != null && _dropDownData.containsKey(newValue)) {
      _selectedImage = newValue;
      notifyListeners();
    }
  }
}
