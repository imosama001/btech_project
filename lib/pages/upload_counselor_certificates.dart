import 'dart:io';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:b_tech_project/repository/user_repository.dart';

class UploadCounselorCertificate extends StatefulWidget {
  @override
  State<UploadCounselorCertificate> createState() =>
      _UploadCounselorCertificateState();
}

class _UploadCounselorCertificateState
    extends State<UploadCounselorCertificate> {
  String certifcateImage = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _userRepository = Provider.of<UserRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Your Certificates"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Please upload your certificate as a Counselor to help us verify you as a Counselor.",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: GestureDetector(
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
                      certifcateImage = value != null ? value.path : '';
                      print(certifcateImage);
                    });
                  }
                });
              },
              child: certifcateImage.isEmpty
                  ? Container(
                      height: size.height * .5,
                      width: size.width * .9,
                      child: const Icon(
                        Icons.add_a_photo,
                        size: 40,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
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
                      height: size.height * .5,
                      width: size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(
                            File(certifcateImage),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.amber)),
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Row(
                  children: const [
                    Expanded(child: Text("Uploading....")),
                    CircularProgressIndicator(),
                  ],
                )));

                if (certifcateImage.isNotEmpty) {
                  await _userRepository
                      .uploadCounselorCertificate(image: File(certifcateImage))
                      .then((value) => Navigator.of(context).pop())
                      .catchError((error) {
                    throw error;
                  });
                } else {
                  Fluttertoast.showToast(msg: "Upload Photo");
                }
              },
              child: const Text(
                "Upload Certificate",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
