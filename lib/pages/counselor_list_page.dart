import 'package:b_tech_project/repository/gwt_consuler.dart';
import 'package:b_tech_project/repository/user_repository.dart';
import 'package:b_tech_project/widgets/doctors_category_cell.dart';
import 'package:b_tech_project/widgets/trd_cell.dart';
import 'package:b_tech_project/widgets/counselor_hd_cell.dart';
import 'package:b_tech_project/utilites/doctor_categories.dart';
import 'package:b_tech_project/utilites/doctor_parameter.dart';
import 'package:b_tech_project/pages/counselor_details_page.dart';
import 'package:b_tech_project/widgets/icons.dart';
import 'package:b_tech_project/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/customtextfield2.dart';

class CounselorListPage extends StatefulWidget {
  @override
  _CounselorListPageState createState() => _CounselorListPageState();
}

class _CounselorListPageState extends State<CounselorListPage> {
  final TextEditingController _searchFieldTextEditingController =
      TextEditingController();

  List<Doctor> _hDoctors = <Doctor>[];
  final List<Category> _categories = <Category>[];
  List<Doctor> _trDoctors = <Doctor>[];

  /// **********************************************
  /// ACTIONS
  /// **********************************************
  _onCellTap(Doctor doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CounselorDetails(doctor: doctor),
      ),
    );
  }

  bool isLoading = true;

  /// **********************************************
  /// LIFE CYCLE METHODS
  /// **********************************************
  @override
  void initState() {
    super.initState();
    // _hDoctors = _getHDoctors();
    //_categories = _getCategories();
    // _trDoctors = _getHDoctors();
  }

  bool isDataLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (!isDataLoaded) {
      _getHDoctors().then((doctorsList) {
        _hDoctors = doctorsList;
        _trDoctors = doctorsList;
        setState(() {
          isLoading = false;
          isDataLoaded = true;
        });
      });
    }
    print(isDataLoaded);
    return Scaffold(
      appBar: AppBar(
        title: Text("Doc"),
        backgroundColor: Colors.transparent,
      ),
      // _buildAppBar(),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: !isDataLoaded
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField2(
                      controller: _searchFieldTextEditingController,
                      hintText: "Search",
                      obscureText: false,
                      onEditingComplete: (_value) {
                        // _pageProvider.getUsers(name: _value);
                        FocusScope.of(context).unfocus();
                      }),
                  _hDoctorsSection(),
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // _categorySection(),
                        const SizedBox(
                          height: 32,
                        ),
                        _trDoctorsSection(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// **********************************************
  /// WIDGETS
  /// **********************************************
  // AppBar _buildAppBar() {
  //   return AppBar(
  //     backgroundColor: Colors.white,
  //     elevation: 0,
  //     brightness: Brightness.light,
  //     iconTheme: IconThemeData(color: HexColor('#150047')),
  //     leading: IconButton(
  //       icon: const Icon(
  //         Icons.menu,
  //         size: 14,
  //       ),
  //       onPressed: () {},
  //     ),
  //     actions: [
  //       IconButton(
  //         icon: const Icon(
  //           Icons.search,
  //           size: 20,
  //         ),
  //         onPressed: () {},
  //       ),
  //     ],
  //   );
  // }

  /// Highlighted Doctors Section
  SizedBox _hDoctorsSection() {
    return SizedBox(
      height: 199,
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _hDoctors.length,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(indent: 16),
        itemBuilder: (BuildContext context, int index) => HDCell(
          doctor: _hDoctors[index],
          onTap: () => _onCellTap(_hDoctors[index]),
        ),
      ),
    );
  }

  /// Category Section
  // Column _categorySection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'Categories',
  //         style: TextStyle(
  //           color: Colors.black,
  //           fontSize: 18,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 32,
  //       ),
  //       SizedBox(
  //         height: 100,
  //         child: ListView.separated(
  //           primary: false,
  //           shrinkWrap: true,
  //           scrollDirection: Axis.horizontal,
  //           itemCount: _categories.length,
  //           separatorBuilder: (BuildContext context, int index) =>
  //               const Divider(indent: 16),
  //           itemBuilder: (BuildContext context, int index) =>
  //               CategoryCell(category: _categories[index]),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  /// Top Rated Doctors Section
  Column _trDoctorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top Rated Doctor',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: _trDoctors.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 16,
            color: Colors.transparent,
          ),
          itemBuilder: (BuildContext context, int index) =>
              TrdCell(doctor: _trDoctors[index]),
        ),
      ],
    );
  }

  /// **********************************************
  /// DUMMY DATA
  /// **********************************************
  /// Get Highlighted Doctors List
  Future<List<Doctor>> _getHDoctors() async {
    UserRepository userRepository = UserRepository();
    var doctors = await userRepository.getCounselorUsers();

    List<Doctor> hDoctors = <Doctor>[];

    // hDoctors.add(Doctor(
    //   firstName: 'Albert',
    //   lastName: 'Alexander',
    //   image: const Image(image: AssetImage("images/mathew.png")),
    //   type: 'Psychology',
    //   rating: 4.5,
    // ));
    // hDoctors.add(Doctor(
    //   firstName: 'Elisa',
    //   lastName: 'Rose',
    //   image: const Image(image: AssetImage('iamges/albert.png')),
    //   type: 'Psychology',
    //   rating: 4.5,
    // ));

    return doctors;
    // }

    // /// Get Categories
    // List<Category> _getCategories() {
    //   List<Category> categories = <Category>[];
    //   categories.add(Category(
    //     icon: CustomIcons.cardiologist,
    //     title: 'Cardiologist',
    //   ));
    //   categories.add(Category(
    //     icon: CustomIcons.eyes,
    //     title: 'Eyes',
    //   ));
    //   categories.add(Category(
    //     icon: CustomIcons.pediatrician,
    //     title: 'Pediatrician',
    //   ));
    //   return categories;
    // }

    // /// Get Top Rated Doctors List
    // List<Doctor> _getTRDoctors() {
    //   List<Doctor> trDoctors = <Doctor>[];

    //   trDoctors.add(Doctor(
    //     firstName: 'Mathew',
    //     lastName: 'Chambers',
    //     image: 'mathew.png',
    //     type: 'Bone',
    //     rating: 4.3,
    //   ));
    //   trDoctors.add(Doctor(
    //       firstName: 'Cherly',
    //       lastName: 'Bishop',
    //       image: 'cherly.png',
    //       type: 'Kidney',
    //       rating: 4.7));
    //   trDoctors.add(Doctor(
    //       firstName: 'Albert',
    //       lastName: 'Alexander',
    //       image: 'albert.png',
    //       type: 'Kidney',
    //       rating: 4.3));
    //   trDoctors.add(Doctor(
    //     firstName: 'Elisa',
    //     lastName: 'Rose',
    //     image: 'albert.png',
    //     type: 'Kidney',
    //     rating: 4.5,
    //   ));
    //   return trDoctors;
  }
}
