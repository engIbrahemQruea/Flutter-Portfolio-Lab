import 'package:dvld/core/di/dependency_injection.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/cubit/person_selector_cubit.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/widgets/person_selector_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonSelector extends StatelessWidget {
  const PersonSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PersonSelectorCubit>(),
      child: PersonSelectorView(),
    );
  }
}


