import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:flutter/material.dart';

class AddUpdatePeopleFormControllers {
  final formKey = GlobalKey<FormState>();
  final personIDController = TextEditingController();
  final nationalNoController = TextEditingController();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final thirdNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final genderController = TextEditingController(text: '0');
  final emailController = TextEditingController();
  final countryController = TextEditingController(text: 'Jordan');
  final phoneController = TextEditingController();
  final imagePathController = TextEditingController();
  final addressController = TextEditingController();

  void updateControllersFromModel({required PeopleEntity people,required String countryName}) {
    personIDController.text = people.personId.toString();
    nationalNoController.text = people.nationalNo;
    firstNameController.text = people.firstName;
    secondNameController.text = people.secondName;
    thirdNameController.text = people.thirdName ?? '';
    lastNameController.text = people.lastName;
    dateOfBirthController.text = people.dateOfBirth;
    genderController.text = people.gender.toString();
    emailController.text = people.email ?? '';
    //countryController.text = people.nationalityCountryId.toString();
    countryController.text = countryName;
    phoneController.text = people.phone;
    imagePathController.text = people.imagePath ?? '';
    addressController.text = people.address;
  }

  void disposeProviderFormControllers() {
    formKey.currentState?.dispose();
    personIDController.dispose();
    nationalNoController.dispose();
    firstNameController.dispose();
    secondNameController.dispose();
    thirdNameController.dispose();
    lastNameController.dispose();
    dateOfBirthController.dispose();
    genderController.dispose();
    emailController.dispose();
    countryController.dispose();
    phoneController.dispose();
    imagePathController.dispose();
    addressController.dispose();
  }
}
