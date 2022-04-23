import 'package:b_tech_project/colors.dart';
import 'package:b_tech_project/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddCounsellorDetails extends StatefulWidget {
  const AddCounsellorDetails({Key? key}) : super(key: key);

  @override
  State<AddCounsellorDetails> createState() => _AddCounsellorDetailsState();
}

class _AddCounsellorDetailsState extends State<AddCounsellorDetails> {
  String counselorDescription = "";
  String location = "";
  String speciality = "";
  String yearOfExperience = "";
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _userRepository = Provider.of<UserRepository>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Provide Counselor's Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(size.width * .033),
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: size.height * .07,
              width: size.width * .9,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                color: kBackgroundColor,
                borderRadius: BorderRadius.circular(size.width * .03),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    location = value;
                  });
                },
                minLines: 2,
                maxLines: 10,
                //controller: TextEditingController(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: " Please Provide your location",
                  hintStyle: TextStyle(
                      color: Colors.grey, fontSize: size.width * .035),
                ),
                style: TextStyle(fontSize: size.width * .05),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Container(
              margin: EdgeInsets.all(size.width * .033),
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: size.height * .07,
              width: size.width * .9,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                color: kBackgroundColor,
                borderRadius: BorderRadius.circular(size.width * .03),
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    speciality = value;
                  });
                },
                minLines: 2,
                maxLines: 10,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: " Your Speciality ?",
                  hintStyle: TextStyle(
                      color: Colors.grey, fontSize: size.width * .035),
                ),
                style: TextStyle(fontSize: size.width * .05),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Container(
              margin: EdgeInsets.all(size.width * .033),
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: size.height * .07,
              width: size.width * .9,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                color: kBackgroundColor,
                borderRadius: BorderRadius.circular(size.width * .03),
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    yearOfExperience = value;
                  });
                },
                minLines: 2,
                maxLines: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: " Please provide year of experience you have...",
                  hintStyle: TextStyle(
                      color: Colors.grey, fontSize: size.width * .035),
                ),
                style: TextStyle(fontSize: size.width * .05),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Container(
              margin: EdgeInsets.all(size.width * .033),
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: size.height * .15,
              width: size.width * .9,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                color: kBackgroundColor,
                borderRadius: BorderRadius.circular(size.width * .03),
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    counselorDescription = value;
                  });
                },
                minLines: 4,
                maxLines: 10,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: " Please Enter Detailed Description of yourself..",
                  hintStyle: TextStyle(
                      color: Colors.grey, fontSize: size.width * .035),
                ),
                style: TextStyle(fontSize: size.width * .05),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if (location.isNotEmpty &&
                      speciality.isNotEmpty &&
                      yearOfExperience.isNotEmpty &&
                      counselorDescription.isNotEmpty) {
                    await _userRepository.addCounselorDetails(
                        location: location,
                        speciality: speciality,
                        yearOfExperience: yearOfExperience,
                        counselorDescription: counselorDescription);
                    print("profile updated");

                    Fluttertoast.showToast(
                        msg: "Counselor Details updated successfully");
                    Navigator.of(context).pop();
                  } else {
                    Fluttertoast.showToast(msg: "Enter all Fields");
                    print("profile not updated");
                  }
                },
                child: Text("Update Profile"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber))),
          ],
        ),
      ),
    );
  }
}
