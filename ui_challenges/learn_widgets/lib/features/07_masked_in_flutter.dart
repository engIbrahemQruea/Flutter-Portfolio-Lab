import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskedInFlutter extends StatelessWidget {
  const MaskedInFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    var dateMaskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {
        "#": RegExp(r'[0-9]'),
      }, // هنا حددنا أن # تعني أرقام فقط (مثل 0 في C#)
      type: MaskAutoCompletionType.lazy,
    );
    var phoneMaskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    var ssnMaskFormatter = MaskTextInputFormatter(
      mask: '###-##-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    var creditCardMaskFormatter = MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Masked In Flutter')),
      body: Column(
        children: [
          TextField(
            inputFormatters: [dateMaskFormatter], // هنا نضع القناع
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "DD/MM/YYYY",
              helperText: "Format: 00/00/0000",
            ),
          ),

          TextField(
            inputFormatters: [phoneMaskFormatter],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "(123) 456-7890",
              helperText: "Format: (000) 000-0000",
            ),
          ),
          TextField(
            inputFormatters: [ssnMaskFormatter],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "123-45-6789",
              helperText: "Format: 000-00-0000",
            ),
          ),
          TextField(
            inputFormatters: [creditCardMaskFormatter],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "1234 5678 9012 3456",
              helperText: "Format: 0000 0000 0000 0000",
            ),
          ),
          TextField(
            inputFormatters: [
              MaskTextInputFormatter(
                mask: 'AA-####',
                filter: {
                  "A": RegExp(r'[A-Za-z]'), // A تعني حروف فقط
                  "#": RegExp(r'[0-9]'), // # تعني أرقام فقط
                },
                type: MaskAutoCompletionType.lazy,
              ),
            ],
            decoration: InputDecoration(
              hintText: "AB-1234",
              helperText: "Format: AA-0000",
            ),
          ),
        ],
      ),
    );
  }
}
