// تعريف الـ Delegate كـ Typedef مطابق لكود المدرب
typedef MyDelegate = void Function(String message);

// كلاس مخصص لمحاكاة الـ Multicast Delegate بكود نظيف
class DartMulticastDelegate {
  // هذه هي الـ Invocation List الداخلية
  final List<MyDelegate> _invocationList = [];

  // محاكاة الـ +=
  void add(MyDelegate method) {
    if (!_invocationList.contains(method)) {
      _invocationList.add(method);
    }
  }

  // محاكاة الـ -=
  void remove(MyDelegate method) {
    _invocationList.remove(method);
  }

  // محاكاة عملية الاستدعاء (Invocation) وتمرير النص لجميع المشتركين بالترتيب
  void invoke(String message) {
    for (var method in _invocationList) {
      method(message);
    }
  }
}
