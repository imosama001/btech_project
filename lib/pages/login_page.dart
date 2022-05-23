import 'package:b_tech_project/colors.dart';
import 'package:b_tech_project/pages/registration_page.dart';
import 'package:b_tech_project/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:b_tech_project/widgets/login_button.dart';
import 'package:b_tech_project/pages/home_page.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _userRepository = Provider.of<UserRepository>(context);

    Size size = MediaQuery.of(context).size;

    void _showErrorSnackBar({required String errorCode}) {
      String errorText;
      if (errorCode == 'wrong-password' ||
          errorCode == 'ERROR_WRONG_PASSWORD') {
        errorText = 'Wrong password, try again';
      } else if (errorCode == 'user-not-found' ||
          errorCode == 'ERROR_USER_NOT_FOUND') {
        errorText = 'Account not found, go to Register page';
      } else if (errorCode == 'user-disabled' ||
          errorCode == 'ERROR_USER_DISABLED') {
        errorText = 'Account disabled';
      } else if (errorCode == 'operation-not-allowed' ||
          errorCode == 'too-many-requests' ||
          errorCode == 'ERROR_TOO_MANY_REQUESTS') {
        errorText = 'Too many invalid requests, try again in 5 minutes';
      } else if (errorCode == 'invalid-email' ||
          errorCode == 'ERROR_INVALID_EMAIL') {
        errorText = 'Invalid email';
      } else if (errorCode == 'operation-not-allowed' ||
          errorCode == 'ERROR_OPERATION_NOT_ALLOWED') {
        errorText = 'Server error, please try again later.';
      } else if (errorCode == 'network-request-failed') {
        errorText = 'Check your interner connection';
      } else {
        errorText = 'Login failed, try again!';
      }

      // ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Row(
      //       children: [
      //         Expanded(child: Text(errorText)),
      //         Icon(
      //           Icons.error,
      //           color: Colors.white,
      //         ),
      //       ],
      //     ),
      //   ),
      // );

      Fluttertoast.showToast(msg: errorText);
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: size.width * .25,
                  backgroundImage: const AssetImage('images/logo.png'),
                  //backgroundColor: ,
                ),
                const SizedBox(
                  width: 100,
                  height: 50,
                ),

                // Center(
                //   child: InputBox(
                //     controller: emailController,
                //     icon: Icon(
                //       Icons.mail,
                //       color: kIconColor,
                //     ),
                //     text: "Email",
                //   ),
                // ),

                // InputBox(
                //   obscureText: true,
                //   controller: passwordController,
                //   icon: Icon(
                //     Icons.lock,
                //     color: kIconColor,
                //   ),
                //   text: "Password",
                // ),
                // email field
                Container(
                  width: size.width * .8,
                  height: size.height * .065,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: kBoxShadowColor,
                        spreadRadius: 1,
                        offset: Offset(0, 2),
                      ),
                      BoxShadow(blurRadius: 3, spreadRadius: -4)
                    ],
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: kHomePageContainerColor,
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        fontSize: size.height * .025,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: size.height * .025,
                    ),
                    cursorColor: kHomePageContainerColor,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),

                // password field
                Container(
                  width: size.width * .8,
                  height: size.height * .065,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: kBoxShadowColor,
                        spreadRadius: 1,
                        offset: Offset(0, 2),
                      ),
                      BoxShadow(blurRadius: 3, spreadRadius: -4)
                    ],
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: kHomePageContainerColor,
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: size.height * .025,
                        color: Colors.black38,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: size.height * .025,
                    ),
                    cursorColor: kBoxShadowColor,
                  ),
                ),

                SizedBox(
                  height: size.height * 0.05,
                ),
                // login button
                LoginButton(
                  buttonText: "Log in",
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Row(
                      children: const [
                        Expanded(child: Text('Loging in...')),
                        CircularProgressIndicator(),
                      ],
                    )));

                    await _userRepository
                        .login(emailController.value.text,
                            passwordController.value.text).then((user) {
                              if (user != null) {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              }
                    })
                        .catchError((error) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      print(error.code.toString() + ' on loginPage');
                      _showErrorSnackBar(errorCode: error.code);
                    });


                  },
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),

                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        }, pageBuilder: (BuildContext context,
                            Animation animation1, Animation animation2) {
                          return const Text("ForgetPassword");
                        }),
                      );
                    },
                    child: const Text('Forgot password?')),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: const Text(
                    "Not a member already?",
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                ),
                //Registration button here...
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationPage(),
                      ),
                    );
                  },
                  child: const Text("REGISTER"),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
