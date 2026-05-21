import 'package:advanced/001_send_data_between_forms/screen_five.dart';
import 'package:advanced/001_send_data_between_forms/screen_four.dart';
import 'package:advanced/001_send_data_between_forms/screen_seven_typedef.dart';
import 'package:advanced/001_send_data_between_forms/screen_three.dart';
import 'package:advanced/001_send_data_between_forms/screen_tow.dart';
import 'package:flutter/material.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen One'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('This is Screen One')),
          ElevatedButton(
            onPressed: () {
              //الشاشة المر - عند الضغط على زر مثلاً:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailsScreenTow(userId: 101, userName: 'Ibrahim'),
                ),
              );
            },
            child: Text('Send Data Using Counstractor'),
          ),
          ElevatedButton(
            onPressed: () {
              // في الشاشة المرسلة يتم إرسال الـ Record هكذا:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreenThree(
                    userData: (
                      id: 202,
                      name: 'Quraiei',
                      isAdmin: true,
                    ), // تمرير مباشر ومحمي
                  ),
                ),
              );
            },
            child: Text('Send Data Using Record'),
          ),
          ElevatedButton(
            onPressed: () {
              // الأسلوب الاحترافي في فلاتر
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => BlocProvider(
              //       create: (context) =>
              //           UserDetailsCubit(repository: getIt())
              //             ..fetchDetails(userId),
              //       child:
              //           const DetailsScreen(), // الشاشة هنا نظيفة وتستمع للـ State فقط
              //     ),
              //   ),
              // );
            },
            child: Text('Send Data Using Bloc'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailsScreenFour.fromId(101),
                ),
              );

              /// Or
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         const DetailsScreenFour.fromName('Ibrahim'),
              //   ),
              // );
            },
            child: Text('Send Data Using Named Constractor'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ModernDetailsScreenFive(userName: 'Ibrahim'),
                ),
              );
            },
            child: Text('Send Data Using Constructor And Assert'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const delegateScreenSex(),
                ),
              );
            },
            child: Text('Send Data Using Delegate (TypeDef)'),
          ),
        ],
      ),
    );
  }
}
