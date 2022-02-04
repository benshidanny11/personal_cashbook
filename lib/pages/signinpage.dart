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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "My cash book",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            const SizedBox(
              height: 20,
            ),
            _isLoading
                ? const CircularProgressIndicator()
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      final googleProvider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      var credencials = await googleProvider.googleLogin();
                      if (credencials != null) {
                        Navigator.pushReplacementNamed(context, RoutesContants.HOME_ROUTE);
                      } else {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  "images/googleicon.png",
                                  width: 25,
                                  height: 25,
                                ),
                                const Text("Sign in with google",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))
                              ]),
                        ),
                        color: Colors.indigo,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
