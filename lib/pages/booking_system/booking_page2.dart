import 'package:flutter/material.dart';
import 'package:b_tech_project/repository/slotBookingRepository.dart';

class BookingPage2 extends StatefulWidget {
  const BookingPage2({Key? key}) : super(key: key);

  @override
  State<BookingPage2> createState() => _BookingPage2State();
}

class _BookingPage2State extends State<BookingPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: SfCalendar(
      //   view: CalendarView.week,
      //   dataSource: MeetingDataSource(_getDataSource()),
      //   monthViewSettings: const MonthViewSettings(
      //       appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      // ),

      body: Body(),
    );
  }

  // List<Meeting> _getDataSource() {
  //   final List<Meeting> meetings = <Meeting>[];
  //   final DateTime today = DateTime.now();
  //   final DateTime startTime =
  //       DateTime(today.year, today.month, today.day, 9, 0, 0);
  //   final DateTime endTime = startTime.add(const Duration(hours: 1));
  //   meetings.add(Meeting(
  //       'Appointment', startTime, endTime, const Color(0xFF0F8644), false));
  //   return meetings;
  // }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

bool isDataLoaded = false;

class _BodyState extends State<Body> {
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        isDataLoaded = false;
      });
    }
  }

  List<String> timeSlots = ['10 am', '11 am'];
  List<String> seletedTimeSlots = [];

  final SlotRepository _slotRepository = SlotRepository();

  @override
  void dispose() {
    isDataLoaded = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (!isDataLoaded) {
      print('loading data ...');
      setState(() {
        seletedTimeSlots = [];
      });
      _slotRepository
          .getSlots(selectedDate.toString().split(' ')[0])
          .then((slots) {
        for (var slot in slots) {
          setState(() {
            seletedTimeSlots.add(slot['time']);
            print(slot);
          });
        }
      });

      setState(() {
        isDataLoaded = true;
        print(seletedTimeSlots);
      });
    }

    return SizedBox(
      height: size.height,
      width: size.width,
      child: !isDataLoaded
          ? const CircularProgressIndicator()
          : SingleChildScrollView(
              child: Column(
              children: [
                TextButton(
                  onPressed: () async {
                    _selectDate(context);
                  },
                  child: Text(selectedDate != null
                      ? selectedDate.toString().split(' ')[0]
                      : 'Select Date'),
                ),
                for (String slot in timeSlots)
                  GestureDetector(
                    onTap: () {
                      if (seletedTimeSlots.contains(slot)) {
                        setState(() {
                          seletedTimeSlots.remove(slot);
                        });
                      } else {
                        setState(() {
                          seletedTimeSlots.add(slot);
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        border: seletedTimeSlots.contains(slot)
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child: Text(slot),
                    ),
                  ),
                IconButton(
                    onPressed: () {
                      _slotRepository.storeSlots(
                          selectedDate.toString().split(' ')[0],
                          seletedTimeSlots);
                    },
                    icon: const Icon(Icons.add))
              ],
            )),
    );
  }
}

// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].from;
//   }

//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].to;
//   }

//   @override
//   String getSubject(int index) {
//     return appointments![index].eventName;
//   }

//   @override
//   Color getColor(int index) {
//     return appointments![index].background;
//   }

//   @override
//   bool isAllDay(int index) {
//     return appointments![index].isAllDay;
//   }
// }

// class Meeting {
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

//   String eventName;
//   DateTime from;
//   DateTime to;
//   Color background;
//   bool isAllDay;
// }
