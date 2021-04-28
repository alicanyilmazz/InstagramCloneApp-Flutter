import 'package:flutter/material.dart';
import 'package:flutter_sample/core/constant/navigation/navigation_constants.dart';
import 'package:flutter_sample/core/extensions/string_extension.dart';
import 'package:flutter_sample/core/init/lang/language_manager.dart';
import 'package:flutter_sample/core/init/lang/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_sample/core/init/navigation/navigation_service.dart';
import 'package:flutter_sample/core/init/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class SampleScren extends StatelessWidget {
  static const String routeName = '/sample';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (_, __, ___) => SampleScren(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.welcome.locale,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Automatic identity verification which enables you to verify your identity',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/login.png'),
                  )),
                ),
                Column(
                  children: [
                    MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {
                        context.setLocale(LanguageManager.instance.trLocale);
                      },
                      height: 60,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                          ),
                          top: BorderSide(
                            color: Colors.black,
                          ),
                          left: BorderSide(
                            color: Colors.black,
                          ),
                          right: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: () {
                          //context.setLocale(LanguageManager.instance.enLocale);
                          context.read<ThemeNotifier>().changeTheme();
                          // NavigationService.instance.navigateToPage(path: NavigationConstants.TEST_VIEW);
                        },
                        height: 60,
                        //elevation: 0,
                        color: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          'Change Theme',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
