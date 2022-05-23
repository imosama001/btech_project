import 'dart:io';
import 'package:b_tech_project/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:b_tech_project/colors.dart';
import 'package:b_tech_project/repository/user_repository.dart';
import 'package:b_tech_project/widgets/login_button.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // **** TextEditingControllers **** //
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  // **** ends TextEditingControllers ends **** //

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    adressController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.dispose();
  }

  String imageFilePath = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final _userRepository = Provider.of<UserRepository>(context);

    void _showErrorSnackBar({required String errorCode}) {
      String errorText;

      if (errorCode == 'invalid-email' || errorCode == 'ERROR_INVALID_EMAIL') {
        errorText = 'Invalid email';
      } else if (errorCode == 'email-already-in-use' ||
          errorCode == 'account-exists-with-different-credential' ||
          errorCode == 'ERROR_EMAIL_ALREADY_IN_USE') {
        errorText = 'Account already exist with email, go to Login page.';
      } else if (errorCode == 'operation-not-allowed' ||
          errorCode == 'ERROR_OPERATION_NOT_ALLOWED') {
        errorText = 'Server error, please try again later.';
      } else
        errorText = 'Error!';

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Expanded(
                child: Text(errorText),
              ),
              const Icon(
                Icons.error,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/logo.png'),
                  radius: size.width * .25,
                  backgroundColor: kBackgroundColor,
                ),

                GestureDetector(
                  onTap: () async {
                    var image = await ImagePicker()
                        .pickImage(
                            source: ImageSource.gallery,
                            maxHeight: 600,
                            maxWidth: 600)
                        .then((value) {
                      if (mounted) {
                        setState(() {
                          // ignore: avoid_print
                          print(value?.path);
                          print('&&&&&&&&&&&&&&\n%%%%%%%%%%%%');
                          imageFilePath = value != null ? value.path : '';
                          print(imageFilePath);
                        });
                      }
                    });
                  },
                  child: imageFilePath.isEmpty
                      ? Container(
                          height: 100,
                          width: 100,
                          child: const Icon(
                            Icons.add_a_photo,
                            size: 40,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.width),
                            color: kBackgroundColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.width),
                            image: DecorationImage(
                              image: FileImage(
                                File(imageFilePath),
                              ),
                            ),
                          ),
                        ),
                ),
                const SizedBox(
                  height: 30,
                ),

                // InputBox(
                //   icon: Icon(
                //     Icons.person,
                //     color: kIconColor,
                //   ),
                //   text: "Name",
                //   controller: nameController,
                // ),

                // name field
                Container(
                  width: size.width * .8,
                  height: size.height * .065,
                  decoration: BoxDecoration(
                    border: Border.all(color: kContainerBorderColor),
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
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: kHomePageContainerColor,
                      ),
                      hintText: 'Name',
                      hintStyle: TextStyle(
                          fontSize: size.height * .025, color: Colors.black26),
                    ),
                    style: TextStyle(
                      fontSize: size.height * .025,
                    ),
                    cursorColor: kContainerBorderColor,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),

                // InputBox(
                //   icon: Icon(
                //     Icons.email,
                //     color: kIconColor,
                //   ),
                //   text: "Email",
                //   controller: emailController,
                // ),

                Container(
                  width: size.width * .8,
                  height: size.height * .065,
                  decoration: BoxDecoration(
                    border: Border.all(color: kContainerBorderColor),
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
                        color: Colors.black26,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: size.height * .025,
                    ),
                    cursorColor: kContainerBorderColor,
                  ),
                ),

                // InputBox(
                //   icon: Icon(
                //     Icons.lock,
                //     color: kIconColor,
                //   ),
                //   text: "Password",
                //   controller: passwordController,
                // ),
                const SizedBox(
                  height: 18,
                ),

                Container(
                  width: size.width * .8,
                  height: size.height * .065,
                  decoration: BoxDecoration(
                    border: Border.all(color: kContainerBorderColor),
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
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: kHomePageContainerColor,
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: size.height * .025,
                        color: Colors.black26,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: size.height * .025,
                    ),
                    cursorColor: kContainerBorderColor,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),

                // InputBox(
                //   icon: Icon(
                //     Icons.phone,
                //     color: kIconColor,
                //   ),
                //   text: "Phone Number",
                //   controller: phoneController,
                // ),

                Container(
                  width: size.width * .8,
                  height: size.height * .065,
                  decoration: BoxDecoration(
                    border: Border.all(color: kContainerBorderColor),
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
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: kHomePageContainerColor,
                      ),
                      hintText: 'Phone number',
                      hintStyle: TextStyle(
                          fontSize: size.height * .025, color: Colors.black26),
                    ),
                    style: TextStyle(
                      fontSize: size.height * .025,
                    ),
                    cursorColor: kContainerBorderColor,
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                // InputBox(
                //   icon: Icon(
                //     FontAwesomeIcons.solidAddressBook,
                //     color: kIconColor,
                //   ),
                //   text: "Address",
                //   controller: adressController,
                // ),

                // Container(
                //   width: size.width * .8,
                //   height: size.height * .065,
                //   decoration: BoxDecoration(
                //     border: Border.all(color: kContainerBorderColor),
                //     color: kBackgroundColor,
                //     borderRadius: BorderRadius.circular(12),
                //     boxShadow: const [
                //       BoxShadow(
                //         blurRadius: 3,
                //         color: kBoxShadowColor,
                //         spreadRadius: 1,
                //         offset: Offset(0, 2),
                //       ),
                //       BoxShadow(blurRadius: 3, spreadRadius: -4)
                //     ],
                //   ),
                //   child: TextField(
                //     controller: adressController,
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       prefixIcon: const Icon(
                //         FontAwesomeIcons.solidAddressBook,
                //         color: kHomePageContainerColor,
                //       ),
                //       hintText: 'Address',
                //       hintStyle: TextStyle(
                //         fontSize: size.height * .025,
                //         color: Colors.black26,
                //       ),
                //     ),
                //     style: TextStyle(
                //       fontSize: size.height * .025,
                //     ),
                //     cursorColor: kContainerBorderColor,
                //   ),
                // ),

                // const SizedBox(
                //   height: 18,
                // ),

                const SizedBox(
                  height: 18,
                ),

                //Same Login Button is used with parameter text "Register";
                LoginButton(
                  buttonText: "Register",
                  onTap: (imageFilePath.isNotEmpty &&
                          emailController.value.text.isNotEmpty &&
                          passwordController.value.text.length > 4 &&
                          nameController.value.text.isNotEmpty
                      // stateController.value.text.isNotEmpty &&
                      // countryController.value.text.isNotEmpty
                      )
                      ? () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(minutes: 1),
                            content: Row(
                              children: const [
                                Expanded(child: Text('Registering...')),
                                CircularProgressIndicator(),
                              ],
                            ),
                          ));
                          await _userRepository
                              .signup(
                                email: emailController.value.text,
                                password: passwordController.value.text,
                                phoneNumber: phoneController.value.text,
                                name: nameController.value.text,
                                //address: adressController.value.text,
                                // state: stateController.value.text,
                                //country: countryController.value.text,
                                image: File(imageFilePath),
                              )
                              .then(
                                (value) {
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  Navigator.of(context).pop();
                                },
                              )
                              .catchError((error) {
                            _showErrorSnackBar(errorCode: error.code);
                          });
                        }
                      : () {
                          if (imageFilePath.isEmpty) {
                            Fluttertoast.showToast(msg: 'Upload photo');
                          } else {
                            Fluttertoast.showToast(msg: 'Enter all fields');
                            // ignore: avoid_print
                            print("Check for errors");
                          }
                        },
                ),
                SizedBox(
                  height: size.height * .015,
                ),
                const Text(
                  "Already have an account",
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogInPage(),
                      ),
                    );
                  },
                  child: const Text("Login Now"),
                ),

                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
