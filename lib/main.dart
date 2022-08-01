import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'appbinding.dart';
import 'helpers/config_reader.dart';
import 'utils/colors.dart';

// import 'package:wp_notify/wp_notify.dart';

import 'onboarding/splashscreen.dart';
import 'utils/custom_theme.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.init();
  // await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
        path: 'resources/langs',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp()),
  );
  // FIXED: added translations
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (kDebugMode) {
        print("Screen width constrains $constraints.maxWidth");
      }
      final customTheme = CustomTheme(constraints);
      return GetMaterialApp(
        defaultTransition: Transition.rightToLeftWithFade,
        initialBinding: AppBinding(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primarycolor,
          bottomAppBarColor: Colors.white,
          // textTheme: customTheme.changa(),
          textTheme: customTheme.changa(),
          elevatedButtonTheme: customTheme.elevatedButtonTheme(),
          outlinedButtonTheme: customTheme.outlinedButtonTheme(),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          }),
          appBarTheme: const AppBarTheme(
            elevation: 0.8,
            // FIXED: brightness
            // brightness: Brightness.light,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        home: ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return const MySplashScreen();
          },
        ),
      );
    });
  }
}
