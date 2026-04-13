import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkeLableRitchTextWidget extends StatelessWidget {
  const LinkeLableRitchTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rich Text Widget')),
      body: Column(
        children: [
          RichText(
            text: TextSpan(
              text: 'This is a ',
              style: DefaultTextStyle.of(context).style,
              children: const <TextSpan>[
                TextSpan(
                  text: 'rich',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(text: ' text with '),
                TextSpan(
                  text: 'links',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  // هنا يمكنك إضافة GestureRecognizer للتعامل مع النقر على الرابط
                ),
                TextSpan(text: '.'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 16),
              children: [
                TextSpan(text: "للمزيد من المعلومات، قم بزيارة "),
                TextSpan(
                  text: "موقعنا الإلكتروني",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print("Link Clicked!");
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
