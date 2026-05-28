import 'package:flutter/material.dart';

class RestrictionsScreen extends StatefulWidget {
  const RestrictionsScreen({super.key});

  @override
  State<RestrictionsScreen> createState() => _RestrictionsScreenState();
}

class _RestrictionsScreenState extends State<RestrictionsScreen> {
  // كشاف البحث البرمجي لتصفية العوامل بناءً على اختيار المستخدم
  String _selectedFilter = "ALL";

  // قاعدة البيانات المعمارية المأخوذة تماماً من مذكرتك
  final List<Map<String, dynamic>> _operatorRules = [
    {
      "op": "&& , ||",
      "status": "❌ ممنوع كلياً",
      "type": "LOGICAL",
      "desc":
          "عوامل الربط الشرطي الذكي (Short-circuiting)؛ تُدار حصراً من نظام التشغيل لضمان الأداء الافتراضي.",
    },
    {
      "op": "?:",
      "status": "❌ ممنوع كلياً",
      "type": "CONDITIONAL",
      "desc":
          "العامل الشرطي الثلاثي. لا يمكن إعادة صياغته برمجياً، وله شروط صارمة في تساوق أنواع البيانات المرجعة.",
    },
    {
      "op": "sizeof , typeof",
      "status": "❌ ممنوع كلياً",
      "type": "SYSTEM",
      "desc":
          "عوامل سيادية خاصة بـ عتاد النظام (Core Engine) لجلب الأحجام وبنية الكلاسات من الـ Metadata.",
    },
    {
      "op": ". (Point) , ->",
      "status": "❌ ممنوع كلياً",
      "type": "ACCESS",
      "desc":
          "عوامل الوصول للمكونات الحركية؛ حظر تحميلها يحمي الكود من التحول إلى أحجية هلامية غامضة.",
    },
    {
      "op": "checked , unchecked",
      "status": "❌ ممنوع كلياً",
      "type": "SYSTEM",
      "desc":
          "أدوات مراقبة طفح الذاكرة الرقمية (Overflow Check)؛ مرتبطة مباشرة بالمعالج.",
    },
    {
      "op": "=",
      "status": "⚠️ مقيد بشرط",
      "type": "ASSIGNMENT",
      "desc":
          "عامل التعيين لا يُحمل مباشرة، بل يتم عبر صياغة دالة تحويل مخصصة (User-defined Conversion) للطرف الأيسر.",
    },
    {
      "op": "== و !=",
      "status": "⚠️ مقيد بشرط",
      "type": "EQUALITY",
      "desc":
          "قاعدة التلازم الإلزامي: يجب تحميلهما معاً كزوج متكامل، ولا تقبل اللغة وجود أحدهما دون الآخر.",
    },
    {
      "op": "< , > , <= , >=",
      "status": "⚠️ مقيد بشرط",
      "type": "COMPARISON",
      "desc":
          "عوامل المقارنة الحجمية: تماماً مثل عوامل التساوي، يجب تحميل المتعاكسات معاً في نفس الوقت.",
    },
    {
      "op": "+= , -= , *= , /=",
      "status": "⚠️ مقيد بشرط",
      "type": "COMPOUND",
      "desc":
          "عوامل التعيين المركبة: لا تُكتب لها دالة مستقلة، بل يتحدد سلوكها تلقائياً بمجرد تحميل العامل الثنائي الأصلي (+ أو -).",
    },
    {
      "op": "[]",
      "status": "⚠️ مقيد بشرط",
      "type": "INDEXER",
      "desc":
          "عامل الفهرسة: يمكن تحميله فقط إذا كان النوع المحتوي عبارة عن مصفوفة (Array) أو خاصية فهرسة (Indexer Property).",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // تصفية القائمة بناءً على التبويب النشط
    List<Map<String, dynamic>> filteredList = _selectedFilter == "ALL"
        ? _operatorRules
        : _operatorRules
              .where(
                (element) => element["status"].contains(
                  _selectedFilter == "BAN" ? "ممنوع" : "مقيد",
                ),
              )
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('🛡️ C# Operator Overloading Guardrails'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 78, 102, 155),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "لوحة المعاينة المعمارية لقواعد قبول ومنع تحميل العوامل إضافياً في لغة C#:",
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),

            // أزرار التصفية السريعة (Filter Tabs)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFilterButton("عرض الكل", "ALL", Colors.blue),
                const SizedBox(width: 8),
                _buildFilterButton("الممنوعة كلياً ❌", "BAN", Colors.redAccent),
                const SizedBox(width: 8),
                _buildFilterButton("المقيدة بشروط ⚠️", "LIMIT", Colors.amber),
              ],
            ),
            const SizedBox(height: 15),

            // 🖥️ عرض القائمة التفاعلية على الشاشة
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final item = filteredList[index];
                  bool isBanned = item["status"].contains("ممنوع");

                  return Card(
                    color: const Color(0xFF121722),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: isBanned
                            ? Colors.redAccent.withOpacity(0.3)
                            : Colors.amber.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // طباعة رمز العامل بخط برمي مخصص
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF090D14),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  item["op"],
                                  style: const TextStyle(
                                    fontFamily: 'Courier',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                              ),
                              // طباعة الحالة الأمنية للـ Compiler
                              Text(
                                item["status"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isBanned
                                      ? Colors.redAccent
                                      : Colors.amber,
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey, height: 20),
                          // الشرح الهندسي للسبب
                          Text(
                            item["desc"],
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.whiteee,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(
    String label,
    String filterValue,
    Color activeColor,
  ) {
    bool isActive = _selectedFilter == filterValue;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? activeColor : const Color(0xFF121722),
        foregroundColor: Colors.whiteee,
        side: BorderSide(color: activeColor.withOpacity(0.5)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      ),
      onPressed: () => setState(() => _selectedFilter = filterValue),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// تعديل بسيط لدعم تلوين النص الافتراضي
class Colors {
  static const Color whiteee = Color(0xFFE2E8F0);
  // سحب بقية الألوان القياسية تلقائياً من الماتيريال
  static const Color blue = MaterialColor(0xFF2196F3, {});
  static const Color redAccent = MaterialColor(0xFFFF5252, {});
  static const Color amber = MaterialColor(0xFFFFC107, {});
  static const Color cyanAccent = MaterialColor(0xFF18FFFF, {});
  static Color grey = MaterialColor(0xFF9E9E9E, {});
}
