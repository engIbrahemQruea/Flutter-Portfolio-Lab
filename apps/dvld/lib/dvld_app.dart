import 'package:dvld/core/routing/app_router.dart';
import 'package:flutter/material.dart';

class DvldApp extends StatelessWidget {
  const DvldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DVLD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: AppRouter.router,
    );
  }
}
