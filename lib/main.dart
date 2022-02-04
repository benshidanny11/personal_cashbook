import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_expenses/pages/signinpage.dart';
import 'package:my_expenses/providers/goolgesigninprovider.dart';
import 'package:my_expenses/providers/transaction_provider.dart';
import 'package:my_expenses/utils/color_util.dart';
import 'package:provider/provider.dart';
import 'package:my_expenses/contants/routes_constants.dart';
import 'package:my_expenses/pages/addentry.dart';
import 'package:my_expenses/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? _user;

  @override
  void initState() {
    _user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TransactionProvider>(
          create: (_) => TransactionProvider(),
        ),
        ChangeNotifierProvider<GoogleSignInProvider>(
            create: (_) => GoogleSignInProvider())
      ],
      child: MaterialApp(
        title: 'My expences',
        theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: 'poppins'),
        home: _user!=null?const SignPage():const SignPage(),
        routes: {
          RoutesContants.ADD_ENTRY: (context) => AddEntry(),
          RoutesContants.HOME_ROUTE:(_)=>const HomeScreen(title: "Cash book app",),
        },
      ),
    );
  }
}
