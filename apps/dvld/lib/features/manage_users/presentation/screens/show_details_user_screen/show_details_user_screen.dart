import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/manage_users/presentation/screens/shared_user_widgets/user_information_card_widget/user_information_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowDetailsUserScreen extends StatelessWidget {
  const ShowDetailsUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            UserInformationCardWidget(),
            verticalSpace(20),
            AppButton.custom(
              label: 'Close',
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
