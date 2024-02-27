import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hellogram/providers/user_provider.dart';
import 'package:hellogram/responsive/mobile_screen_layout.dart';
import 'package:hellogram/responsive/responsive_layout_screen.dart';
import 'package:hellogram/responsive/web_screen_layout.dart';
import 'package:hellogram/screens/login_screen.dart';
import 'package:hellogram/utils/colors.dart';
import 'package:hellogram/utils/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyBjRVAivoVdkLUgPp0-p1LIUfZKL5LoFvc",
  //         appId: "1:1096608712752:android:f69559f560a42e55fe85f5",
  //         messagingSenderId: "836239946911",
  //         projectId: "hellogram-ea6ed",
  //         storageBucket: "hellogram-ea6ed.appspot.com"),
  //   );
  // } else {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBjRVAivoVdkLUgPp0-p1LIUfZKL5LoFvc",
        appId: "1:1096608712752:android:f69559f560a42e55fe85f5",
        messagingSenderId: "836239946911",
        projectId: "hellogram-ea6ed",
        storageBucket: "hellogram-ea6ed.appspot.com"),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider())
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hellogram',
            themeMode: themeProvider.themeMode,
            theme: MyTheme.lightTheme(),
            darkTheme: MyTheme.darkTheme(),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return const ResponsiveLayout(
                        webScreenLayout: WebSreenLayout(),
                        mobileScreenLayout: MobileScreenLayout());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }

                return const LoginScreen();
              },
            ));
      },
    );
  }
}
