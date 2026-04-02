import 'package:flutter/material.dart';

class IntroAboutWidget extends StatefulWidget {
  const IntroAboutWidget({super.key});

  @override
  State<IntroAboutWidget> createState() => _IntroAboutWidgetState();
}

class _IntroAboutWidgetState extends State<IntroAboutWidget> {
  final TextEditingController _t1 = TextEditingController();
  final TextEditingController _t2 = TextEditingController();
  bool _isDisabled = false;
  Color _buttonColor = Colors.blue;
  bool _isVisible = true;
  bool _isEnabled = true;
  String _lableText = '';

  Future<bool> _confirm(BuildContext context, String title, String ok) async {
    bool? result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('تنبيه'),
        icon: Icon(Icons.warning, color: Colors.red),
        scrollable: true,
        semanticLabel: "title Dialog",
        content: Text("هل أنت متأكد  ؟  $title"),
        actions: [
          TextButton(
            autofocus: true,
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(ok),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Learn Widget')),
        body: Visibility(
          visible: _isVisible,

          // maintainSize: true,
          //  maintainAnimation: true,
          //  maintainState: true,
          // maintainInteractivity: true,
          replacement: Center(
            child: ElevatedButton(
              onPressed: () async {
                _isVisible = await _confirm(context, 'Visible', "Ok");
                setState(() {});
              },
              child: Text(
                'Visible All',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _t1,
                enabled: _isEnabled,
                onChanged: (value) {
                  setState(() {
                    _t2.text = value; // Copy text from _t1 to _t2
                  });
                },
                decoration: InputDecoration(
                  labelText: 'What is a Widget?',
                  helperText:
                      'A Widget is a basic building block of the Flutter UI.',
                  hintText: 'Enter your answer here',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(controller: _t2),
              const SizedBox(height: 20),
              Text(
                _lableText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _buttonColor,
                ),
              ),
              Wrap(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      bool shouldCopy = await _confirm(context, "Copy", 'ok');
                      if (shouldCopy) {
                        setState(() {
                          _lableText = _t1.text; // Copy text from _t1 to label
                        });
                      }
                    },
                    child: Text('Copy Text'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool _enabled = await _confirm(context, "Enable", 'ok');
                      setState(() {
                        _isVisible = !_enabled;
                      });
                    },
                    child: Text('UnVisible All'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _buttonColor = Colors.red;
                      });
                    },
                    child: Text('Change Color'),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Hover Me'),
                    ),
                  ),
                  MouseRegion(
                    // button2_MouseEnter يحاكي هذا
                    onEnter: (_) => setState(() {
                      _t2.text = _t1.text;
                    }),
                    child: Container(
                      color: Colors.amber,

                      child: Text("Hover Me"),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      bool _enabled = await _confirm(context, "Enable", 'ok');
                      setState(() {
                        _isEnabled = _enabled;
                      });
                    },
                    child: Text('Enable'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEnabled = false;
                      });
                    },
                    child: Text('Disable'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
