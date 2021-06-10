import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constant/enums/app_theme_enum.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/init/notifier/theme_notifier.dart';
import '../../repositories/auth/auth_repository.dart';
import 'cubit/signup_cubit.dart';

class SignupScren extends StatelessWidget {
  static const String routeName = '/signup';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<SignupCubit>(
        create: (_) =>
            SignupCubit(authRepository: context.read<AuthRepository>()),
        child: SignupScren(),
      ),
    );
  }

  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.status == SignupStatus.error) {
              showDialog(
                context: context,
                barrierColor: Colors.black45,
                builder: (context) => AlertDialog(
                  title: Text('Warning'),
                  content: Text(state.failure.message),
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      icon: context.watch<ThemeNotifier>().currentThemeEnum ==
                              AppThemes.LIGHT
                          ? Icon(Icons.nightlight_round)
                          : Icon(Icons.wb_sunny),
                      onPressed: () {
                        context.read<ThemeNotifier>().changeTheme();
                      }),
                ],
              ),
              resizeToAvoidBottomInset: false,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    color: context.theme.cardColor,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _signupFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Pharmacy Markets',
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Username',
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.black54,
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 14, right: 15),
                              ),
                              onChanged: (value) => context
                                  .read<SignupCubit>()
                                  .usernameChanged(value),
                              validator: (value) => value.trim().isEmpty
                                  ? 'Username is not empty.'
                                  : null,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Email',
                                prefixIcon: Icon(
                                  Icons.email_rounded,
                                  color: Colors.black54,
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 14, right: 15),
                              ),
                              onChanged: (value) => context
                                  .read<SignupCubit>()
                                  .emailChanged(value),
                              validator: (value) => !value.contains('@')
                                  ? 'Please enter a valid email.'
                                  : null,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black54,
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 14, right: 15),
                              ),
                              obscureText: true,
                              onChanged: (value) => context
                                  .read<SignupCubit>()
                                  .passwordChanged(value),
                              validator: (value) => value.length < 6
                                  ? 'Must be et least 6 characters.'
                                  : null,
                            ),
                            const SizedBox(
                              height: 28.0,
                            ),
                            ElevatedButton(
                              onPressed: () => _submitForm(context,
                                  state.status == SignupStatus.submitting),
                              child: Text('Sign Up'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black87),
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            ElevatedButton(
                              onPressed: () => {Navigator.of(context).pop()},
                              child: Text('Have an account? Log In'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black87),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _submitForm(BuildContext context, bool isSubmitting) {
    if (_signupFormKey.currentState.validate() && !isSubmitting) {
      context.read<SignupCubit>().signUpWithCredentials();
    }
  }
}
