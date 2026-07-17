import 'package:dvld/features/people/presentation/logic/cubit/get_all_people_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BlocListenerDeletePeople extends StatelessWidget {
  const BlocListenerDeletePeople({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetAllPeopleCubit, GetAllPeopleState>(
      listener: (context, state) {
        if (state is DeletePeopleLoading) {
          showDialog(
            context: context,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        }
        if (state is DeletePeopleSuccess) {
          //context.pop(context);
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Person deleted successfully'),
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
        if (state is DeletePeopleFailure) {
          //context.pop(context);
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(state.errMessage),
                icon: const Icon(Icons.error, color: Colors.red),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => context.pop(context),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
