// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/features/people/presentation/screens/sub_screens/widgets_add_update_people_screen/body_add_update_screen.dart';
import 'package:flutter/material.dart';

class AddUpdatePeopleScreen extends StatelessWidget {
  const AddUpdatePeopleScreen({Key? key, this.personId}) : super(key: key);

  final int? personId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          personId == null ? 'Add People Screen' : 'Update People Screen',
        ),
      ),
      body: BodyAddUpdateScreen(personId: personId),
    );
  }
}
