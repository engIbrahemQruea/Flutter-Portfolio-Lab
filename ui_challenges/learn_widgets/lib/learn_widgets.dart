import 'package:flutter/material.dart';
import 'package:learn_widgets/core/image_provider.dart';
import 'package:learn_widgets/features/01_intro_about_widget.dart';
import 'package:learn_widgets/features/02_default_text_style.dart';
import 'package:learn_widgets/features/03_foucs_widget.dart';
import 'package:learn_widgets/features/04_check_box.dart';
import 'package:learn_widgets/features/05_image_widget_exercise.dart';
import 'package:learn_widgets/features/06_draw_custom_painter.dart';
import 'package:provider/provider.dart';

class LearnWidgets extends StatelessWidget {
  const LearnWidgets({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Widgets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      // home: const IntroAboutWidget(),
      // home: const DefaultTextStyleWidget(),
      //home: const FocusExample(),
      //   home: const CheckBoxWidget(),
      // home: const CheckboxExample(),
      // home: const CheckboxExampleTwo(),
      // home: ChangeNotifierProvider(
      //   create: (context) => ImageWidgetProvider(),
      //   child: ImageWidgetExercise()),
      home: const DrawCustomPainter(),
    );
  }
}
