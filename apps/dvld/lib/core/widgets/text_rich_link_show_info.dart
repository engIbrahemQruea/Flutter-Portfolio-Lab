// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextRichLinkShowInfo extends StatelessWidget {
  const TextRichLinkShowInfo({super.key, required this.text, this.onLinkTap});

  final String text;
  final Function()? onLinkTap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.wavy,
            ),
            mouseCursor: SystemMouseCursors.precise,
            recognizer: TapGestureRecognizer()..onTap = () => onLinkTap,
          ),
        ],
      ),
    );
  }
}
