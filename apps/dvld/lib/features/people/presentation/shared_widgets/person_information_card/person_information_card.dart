import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_information_card/widgets/person_address_info.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_information_card/widgets/person_basic_info.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_information_card/widgets/person_contact_info.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_information_card/widgets/person_image.dart';
import 'package:flutter/material.dart';

class PersonInformationCard extends StatelessWidget {
  const PersonInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const Text(
            'Person Information',
            style: TextStyle(
              fontSize: 20,
              textBaseline: TextBaseline.ideographic,
            ),
          ),
          Card.outlined(
            child: Padding(
              padding: const .symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      PersonBasicInfo(),
                      const SizedBox(width: 20),
                      PersonImage(),
                    ],
                  ),
                  verticalSpace(10),
                  PersonContactInfo(),
                  verticalSpace(10),
                  PersonAddressInfo(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
