import 'package:flutter/material.dart';
import 'package:flutter_sample/core/extensions/context_extension.dart';

class LoginScren extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (_, __, ___) =>
          LoginScren(), //https://stackoverflow.com/questions/25517016/what-does-it-mean-to-pass-i-e-underscore-as-the-sole-parameter-to-a-dart
    );
  }

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                color: Colors.deepOrange.shade300,
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
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'Email',
                            labelStyle: context.textTheme.headline2,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                          ),
                          onChanged: (value) => print(value),
                          validator: (value) => !value.contains('@')
                              ? 'Please enter a valid email.'
                              : null,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'Password',
                            labelStyle: context.textTheme.headline2,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                          ),
                          onChanged: (value) => print(value),
                          validator: (value) => value.length < 6
                              ? 'Must be et least 6 characters.'
                              : null,
                        ),
                        const SizedBox(
                          height: 28.0,
                        ),
                        ElevatedButton(
                          onPressed: () => {print('Pressed Login')},
                          child: Text('Log In'),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black87),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        ElevatedButton(
                          onPressed: () => {print('No account? Sign up.')},
                          child: Text('No account? Sign up.'),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
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
        ),
      ),
    );
  }
}
