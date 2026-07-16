// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SaveBlocListener extends StatelessWidget {
  const SaveBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddUpdateFormCubit, AddUpdateFormState>(
      listenWhen: (previous, current) =>
          previous.saveButtonStatus != current.saveButtonStatus,
      listener: (context, state) {
        if (state.saveButtonStatus.saveStatus == RequestStatus.loading) {
          showDialog(
            context: context,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        }
        if (state.saveButtonStatus.saveStatus == RequestStatus.success) {
          context.pop(context);
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Person saved successfully'),
                icon: const Icon(Icons.check, color: Colors.green),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      context.pop(context);
                      context.pop(true);
                    },
                  ),
                ],
              );
            },
          );
        }
        if (state.saveButtonStatus.saveStatus == RequestStatus.failure) {
          context.pop(context);
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                icon: const Icon(Icons.error, color: Colors.red),
                title: const Text('Error'),
                content: Text('${state.saveButtonStatus.errorMessage}'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      context.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
