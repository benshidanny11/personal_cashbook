import 'package:flutter/material.dart';
import 'package:my_expenses/contants/routes_constants.dart';
import 'package:my_expenses/providers/goolgesigninprovider.dart';
import 'package:provider/provider.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:const BoxDecoration(
          color: Colors.indigo,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/applogo_trans.png',width: 250,height: 250,),
              const Text(
                "My cash book",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              _isLoading
                  ? const CircularProgressIndicator(color: Colors.white,)
                  : GestureDetector(
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        final googleProvider =
                            Provider.of<GoogleSignInProvider>(context,
                                listen: false);
                        var credencials = await googleProvider.googleLogin();
                        if (credencials != null) {
                          Navigator.pushReplacementNamed(
                              context, RoutesContants.HOME_ROUTE);
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45, vertical: 0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[300] as Color,
                                    blurRadius: 10,
                                    spreadRadius: 1)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    "images/googleicon.png",
                                    width: 25,
                                    height: 25,
                                  ),
                                  const Text("Sign in with google",
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))
                                ]),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
