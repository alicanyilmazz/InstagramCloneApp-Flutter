import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/components/dialog/error_dialog.dart';
import '../../core/extensions/context_extension.dart';
import '../../repositories/auth/auth_repository.dart';
import 'cubit/login_cubit.dart';
import '../screens.dart';
import 'package:provider/provider.dart';

class LoginScren extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
        create: (_) =>
            LoginCubit(authRepository: context.read<AuthRepository>()),
        child: LoginScren(),
      ),
    );
  }

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                context: context,
                barrierColor: Colors.black45,
                builder: (context) => ErrorDialog(
                  content: state.failure.message,
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [],
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
                        key: _loginFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Instagram Clone',
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
                                hintText: 'Email',
                                prefixIcon: Icon(
                                  Icons.email_rounded,
                                  color: Colors.black54,
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 14, right: 15),
                              ),
                              onChanged: (value) => context
                                  .read<LoginCubit>()
                                  .emailChanged(value.trim().toLowerCase()),
                              validator: (value) =>
                                  !(value!.trim()).contains('@')
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
                                  .read<LoginCubit>()
                                  .passwordChanged(value.trim()),
                              validator: (value) => value!.length < 6
                                  ? 'Must be et least 6 characters.'
                                  : null,
                            ),
                            const SizedBox(
                              height: 28.0,
                            ),
                            ElevatedButton(
                              onPressed: () => _submitForm(context,
                                  state.status == LoginStatus.submitting),
                              child: Text('Log In'),
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
                              onPressed: () => {
                                Navigator.of(context)
                                    .pushNamed(SignupScren.routeName),
                              },
                              child: Text('No account? Sign up.'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black87),
                              ),
                            ),
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
    if (_loginFormKey.currentState!.validate() && !isSubmitting) {
      context.read<LoginCubit>().logInWithCredentials();
    }
  }
}
