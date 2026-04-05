import 'package:flutter/material.dart';
import 'package:learn_widgets/core/constans.dart';

class ImageWidgetProvider with ChangeNotifier {
  String _imageUrl = imBoy;

  final Map<String, String> _imageData = {
    imBoy: 'Boy',
    imGirl: 'Girl',
    imBook: 'Book',
    imPencil: 'Pencil',
  };

  String get imageUrl => _imageUrl;

  String get imageTitle => _imageData[_imageUrl] ?? 'Unknown';
    Map<String, String> get imageData => _imageData;

  void setImageUrl(String url) {
    _imageUrl = url;
    notifyListeners();
  }
}
