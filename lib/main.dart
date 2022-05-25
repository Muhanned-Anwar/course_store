import 'package:course_store/app/profile/edit_profile_screen.dart';
import 'package:course_store/provider/main_position_provider.dart';
import 'package:course_store/provider/my_course_provider.dart';
import 'package:course_store/provider/product_provider.dart';
import 'package:course_store/storage/local/prefs/user_preference_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app/course_details_screen.dart';
import 'app/home_screen.dart';
import 'app/main_screen.dart';
import 'app/product_cart_screen.dart';
import 'app/product_details_screen.dart';
import 'app/profile/change_password_screen.dart';
import 'auth/forget_password_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'launch_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserPreferenceController().initSharedPreferences();
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainPositionProvider>(create: (_) => MainPositionProvider()),
        ChangeNotifierProvider<MyCourseProvider>(create: (_) => MyCourseProvider()),
        ChangeNotifierProvider<ProductProvider>(create: (_) => ProductProvider()),
      ],
      child: const MainMaterialApp(),
    );
  }
}

class MainMaterialApp extends StatefulWidget {
  const MainMaterialApp({Key? key}) : super(key: key);

  @override
  State<MainMaterialApp> createState() => _MainMaterialAppState();
}

class _MainMaterialAppState extends State<MainMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xffECB7BF),
        primarySwatch: Colors.pink,
        fontFamily: 'PlayfairDisplay',
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/launch_screen':(context)=> const LaunchScreen(),
        '/login_screen':(context)=> const LoginScreen(),
        '/register_screen':(context)=> const RegisterScreen(),
        '/forget_password_screen':(context)=> const ForgetPasswordScreen(),
        '/main_screen': (context) => const MainScreen(),
        '/home_screen': (context) => const HomeScreen(),
        '/change_password_screen': (context) => const ChangePasswordScreen(),
        '/course_details_screen': (context) => const CourseDetailsScreen(),
        '/product_details_screen': (context) => const ProductDetailsScreen(),
        '/product_cart_screen': (context) => const ProductCartScreen(),
        '/edit_profile_screen': (context) => const EditProfileScreen(),

      },
      initialRoute: '/launch_screen',
    );
  }
}
