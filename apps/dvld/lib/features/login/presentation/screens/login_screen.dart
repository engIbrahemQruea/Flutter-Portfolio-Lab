import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/features/login/presentation/logic/login_screen_cubit/login_screen_cubit.dart';
import 'package:dvld/features/login/presentation/screens/widgets/login_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginScreenControllers _loginControllers;

  @override
  void initState() {
    super.initState();
    _loginControllers = LoginScreenControllers();
    context.read<LoginScreenCubit>().loadSavedCredentials();
  }

  @override
  void dispose() {
    _loginControllers.formKey.currentState?.dispose();
    _loginControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _loginControllers.formKey,
          child: BlocListener<LoginScreenCubit, LoginScreenCubitState>(
            listenWhen: (previous, current) =>
                previous.loginStatus != current.loginStatus,
            listener: (context, state) {
              if (state.loginStatus.isLoading) {
                AppDialogs.showLoading(
                  context: context,
                  message: 'Please wait...',
                );
              }
              if (state.loginStatus.isSuccess) {
                context.goNamed(DRoutes.dashboard);
              }
              if (state.loginStatus.isFailure) {
                AppDialogs.dismiss(context);
                AppDialogs.showFailure(
                  context: context,
                  title: 'Login Failed',
                  buttonText: 'Ok',
                  message: state.errorMessage ?? 'Something went wrong',
                );
              }
              if (state.loginStatus.isInactiveAccount) {
                AppDialogs.dismiss(context);
                AppDialogs.showWarning(
                  context: context,
                  title: 'Inactive Account',
                  buttonText: 'Ok',
                  message: state.errorMessage ?? 'User is not active',
                );
              }
              if (state.loginStatus.isLoadedCredentials) {
                _loginControllers.initControllers(state.userEntity);
              }
            },
            child: Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    'Login To Your Account',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  verticalSpace(40),
                  UserNameTextFormField(loginControllers: _loginControllers),
                  verticalSpace(15),
                  PasswordTextFormField(loginControllers: _loginControllers),
                  verticalSpace(15),
                  IsRememberMeCheckboxWidget(),
                  verticalSpace(15),
                  LoginButtonWidget(loginControllers: _loginControllers),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
