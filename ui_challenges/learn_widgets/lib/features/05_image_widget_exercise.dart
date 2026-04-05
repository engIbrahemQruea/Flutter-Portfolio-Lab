import 'package:flutter/material.dart';
import 'package:learn_widgets/core/constans.dart';
import 'package:learn_widgets/core/image_provider.dart';
import 'package:provider/provider.dart';

class ImageWidgetExercise extends StatelessWidget {
  const ImageWidgetExercise({super.key});

  @override
  Widget build(BuildContext context) {
    var imageProvider = Provider.of<ImageWidgetProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Image Widget Exercise')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            imageProvider.imageTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Container(
            // width: 200,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imageProvider.imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: imageProvider.imageData.keys.map((path) {
              return ElevatedButton(
                onPressed: () => imageProvider.setImageUrl(path),
                child: Text(imageProvider.imageData[path]!),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
