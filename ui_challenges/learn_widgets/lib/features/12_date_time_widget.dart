import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget({super.key});

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  String labelText = "";
  void _updateLabel(DateTime pickedDate) {
    // محاكاة لكود المدرب بالتفصيل
    labelText = DateFormat('dd-MMM-yyyy').format(pickedDate) + "\n";
    labelText += DateFormat('dddd-MMM-yyyy').format(pickedDate) + "\n";
    labelText += DateFormat('MM-dd-yyyy').format(pickedDate) + "\n";
    labelText += DateFormat('dd/MM/yy  - HH:mm:ss').format(pickedDate) + "\n";
    labelText += DateFormat('EEEE, dd-MMM-yyyy').format(pickedDate);
    setState(() {});
  }

  int age = 0;

  void calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int years = currentDate.year - birthDate.year;
    int months = currentDate.month - birthDate.month;
    int days = currentDate.day - birthDate.day;

    age = years;
    setState(() {});
  }

  // 1. تعريف متغير لحفظ النطاق (يوازي monthCalendar1.SelectionRange)
  DateTimeRange? selectedRange;

  // 2. دالة لفتح التقويم واختيار المدى
  void _selectRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedRange = picked;
      });
    }
  }

  // 3. محاكاة عمل أزرار المدرب (Show Data)
  void showData() {
    if (selectedRange != null) {
      print("Start: ${selectedRange!.start}"); // يوازي Button2
      print("End: ${selectedRange!.end}"); // يوازي Button3
      print("Range: $selectedRange"); // يوازي Button1
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date Time Widget')),
      body: Center(
        child: Column(
          children: [
            Text(
              labelText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text('${age}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected date: $selectedDate')),
                  );
                  _updateLabel(selectedDate);
                  calculateAge(selectedDate);
                }
              },
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 20),
            Container(
              height: 250,
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                onDateChanged: (DateTime date) {
                  // هذا الحدث يوازي DateSelected في C#
                  print("Selected date: $date");
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _selectRange(context);
                showData();
              },
              child: const Text('Select Date Range'),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected time: $selectedTime')),
                  );
                }
              },
              child: const Text('Select Time'),
            ),
          ],
        ),
      ),
    );
  }
}
