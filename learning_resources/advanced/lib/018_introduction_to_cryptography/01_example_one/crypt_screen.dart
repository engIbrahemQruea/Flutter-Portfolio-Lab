// import 'dart:convert';

// import 'package:crypto/crypto.dart' as dart_crypto;
// import 'package:encrypt/encrypt.dart' as env_encrypt;
// import 'package:flutter/material.dart';

// class CryptoScreen extends StatefulWidget {
//   const CryptoScreen({super.key});

//   @override
//   State<CryptoScreen> createState() => _CryptoScreenState();
// }

// class _CryptoScreenState extends State<CryptoScreen> {
//   // أجهزة التحكم بالنصوص للمدخلات والمخرجات
//   final TextEditingController _inputController = TextEditingController(
//     text: "Mohamed Abu-Hadhoud",
//   );

//   String _hashResult = "";
//   String _aesCipherText = "";
//   String _aesDecryptedText = "";
//   String _rsaCipherText = "";
//   String _rsaDecryptedText = "";

//   // إعدادات ومفاتيح التشفير الثابتة للمحاكاة
//   final String _aesSecretKey =
//       "MySecretSymmetricKey123456789012"; // 32 chars for AES-256
//   late env_encrypt.IV _aesIv;
//   late env_encrypt.AsymmetricKeyPair<
//     env_encrypt.RSAPublicKey,
//     env_encrypt.RSAPrivateKey
//   >
//   _rsaKeyPair;

//   @override
//   void initState() {
//     super.initState();
//     // توليد ناقل التهيئة لـ AES وزوج مفاتيح الـ RSA عند إقلاع الشاشة
//     _aesIv = env_encrypt.IV.fromLength(16);
//     _rsaKeyPair = env_encrypt.RSAKeyparser().generateKeyPair();
//   }

//   // 1️⃣ معالجة الـ Hashing (SHA-256)
//   void _executeHashing() {
//     final bytes = utf8.encode(_inputController.text);
//     final digest = dart_crypto.sha256.convert(bytes);
//     setState(() {
//       _hashResult = digest.toString();
//     });
//   }

//   // 2️⃣ معالجة التشفير المتماثل (AES)
//   void _executeAES() {
//     final key = env_encrypt.Key.fromUtf8(_aesSecretKey.substring(0, 32));
//     final encrypter = env_encrypt.Encrypter(env_encrypt.AES(key));

//     final encrypted = encrypter.encrypt(_inputController.text, iv: _aesIv);
//     final decrypted = encrypter.decrypt(encrypted, iv: _aesIv);

//     setState(() {
//       _aesCipherText = encrypted.base64;
//       _aesDecryptedText = decrypted;
//     });
//   }

//   // 3️⃣ معالجة التشفير غير المتماثل (RSA)
//   void _executeRSA() {
//     final encrypter = env_encrypt.Encrypter(
//       env_encrypt.RSA(
//         publicKey: _rsaKeyPair.publicKey,
//         privateKey: _rsaKeyPair.privateKey,
//       ),
//     );

//     final encrypted = encrypter.encrypt(_inputController.text);
//     final decrypted = encrypter.decrypt(encrypted);

//     setState(() {
//       _rsaCipherText = encrypted.base64;
//       _rsaDecryptedText = decrypted;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('🛡️ Crypto Engine Dashboard (C# To Flutter)'),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF1A2333),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // قسم المدخلات الرئيسي
//             _buildSectionCard(
//               title: "📥 Input Plaintext (النص المراد حمايته)",
//               color: Colors.cyan,
//               child: TextField(
//                 controller: _inputController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'اكتب النص الحساس هنا...',
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // 1️⃣ بطاقة الـ Hashing
//             _buildSectionCard(
//               title: "1️⃣ Hashing Section (SHA-256) - اتجاه واحد حتمي",
//               color: Colors.amber,
//               child: Column(
//                 children: [
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.amber.shade700,
//                     ),
//                     onPressed: _executeHashing,
//                     icon: const Icon(Icons.fingerprint),
//                     label: const Text("Generate SHA-256 Hash"),
//                   ),
//                   const SizedBox(height: 10),
//                   _buildResultDisplay(
//                     "البصمة الرقمية (Hash Digest):",
//                     _hashResult,
//                     Colors.amber,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),

//             // 2️⃣ بطاقة الـ AES
//             _buildSectionCard(
//               title: "2️⃣ Symmetric Encryption (AES-256) - مفتاح مشترك",
//               color: Colors.green,
//               child: Column(
//                 children: [
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green.shade700,
//                     ),
//                     onPressed: _executeAES,
//                     icon: const Icon(Icons.vpn_key),
//                     label: const Text("Encrypt & Decrypt via AES"),
//                   ),
//                   const SizedBox(height: 10),
//                   _buildResultDisplay(
//                     "النص المشفر (Ciphertext Base64):",
//                     _aesCipherText,
//                     Colors.green,
//                   ),
//                   _buildResultDisplay(
//                     "النص بعد فك التشفير (Decrypted):",
//                     _aesDecryptedText,
//                     Colors.green,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),

//             // 3️⃣ بطاقة الـ RSA
//             _buildSectionCard(
//               title: "3️⃣ Asymmetric Encryption (RSA) - زوج مفاتيح (عام/خاص)",
//               color: Colors.purple,
//               child: Column(
//                 children: [
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.purple.shade700,
//                     ),
//                     onPressed: _executeRSA,
//                     icon: const Icon(Icons.lock),
//                     label: const Text(
//                       "Encrypt (Public Key) & Decrypt (Private Key)",
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   _buildResultDisplay(
//                     "النص المشفر بالعام (RSA Ciphertext):",
//                     _rsaCipherText,
//                     Colors.purple,
//                   ),
//                   _buildResultDisplay(
//                     "النص المفكوك بالخاص (RSA Decrypted):",
//                     _rsaDecryptedText,
//                     Colors.purple,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ويدجت مساعدة لبناء الحاويات المنظمة بشكل كرتوني أمني مميز
//   Widget _buildSectionCard({
//     required String title,
//     required Color color,
//     required Widget child,
//   }) {
//     return Card(
//       color: const Color(0xFF1A2333),
//       shape: RoundedRectangleBorder(
//         side: BorderSide(color: color.withOpacity(0.5), width: 1),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 color: color,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const Divider(color: Colors.grey, height: 20),
//             child,
//           ],
//         ),
//       ),
//     );
//   }

//   // ويدجت مخصصة لعرض النتائج داخل صناديق نصية رمادية واضحة وقابلة للقراءة
//   Widget _buildResultDisplay(String label, String value, Color textColor) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF0F1520),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: Text(
//                 value.isEmpty ? "في انتظار ضغط الزر..." : value,
//                 style: TextStyle(
//                   fontFamily: 'Courier',
//                   color: value.isEmpty ? Colors.grey : textColor,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
