import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scheduling_ui_app/data/models/slot_data.dart';
import 'package:scheduling_ui_app/views/screens/result_screen.dart';

import '../../controllers/controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0XFFf1f5f9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Online Consultation Slots",
          style: GoogleFonts.montserrat(
            // fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<ConsultationController>(
          builder: (consultationController) {
            return Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: consultationController.days.length,
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    log("${consultationController.days[index]}", name: "INDEX $index");
                    return SlotWidget(index: index);
                  },
                ),
                if (consultationController.days.length != 7)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          consultationController.days.add(SlotData(day: null, slotArray: []));
                          consultationController.update();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.lightBlueAccent,
                            ),
                            Text(
                              "Add More",
                              style: GoogleFonts.montserrat(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: GetBuilder<ConsultationController>(builder: (consultationController) {
        return MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            for (var element in consultationController.days) {
              if (element.day == null || element.day == '') {
                Fluttertoast.showToast(
                  msg: "Please select a day for slot ${consultationController.days.indexOf(element) + 1}",
                  timeInSecForIosWeb: 3,
                );
                return;
              }
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ResultScreen()));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          height: 60,
          child: Text(
            "Save Information",
            style: GoogleFonts.montserrat(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        );
      }),
    );
  }
}

class SlotWidget extends StatefulWidget {
  const SlotWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<SlotWidget> createState() => _SlotWidgetState();
}

DateFormat hMA = DateFormat('hh:mm a');

class _SlotWidgetState extends State<SlotWidget> {
  DateTime time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9);

  List<DateTime> selected = [];
  String? selectedDay;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ConsultationController>(
      builder: (consultationController) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: [
                            "Sunday",
                            "Monday",
                            "Tuesday",
                            "Wednesday",
                            "Thursday",
                            "Friday",
                            "Saturday",
                          ]
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          borderRadius: BorderRadius.circular(12),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          hint: Text(
                            "Select Day",
                            style: GoogleFonts.montserrat(
                              fontSize: 14.0,
                            ),
                          ),
                          value: consultationController.days[widget.index].day,
                          onChanged: (value) {
                            if (consultationController.days.length == 1) {
                              selectedDay = value;
                              consultationController.days[widget.index].day = value;
                            } else if (consultationController.days.where((element) => element.day == value).isNotEmpty) {
                              Fluttertoast.showToast(msg: "Day already selected", timeInSecForIosWeb: 3);
                            } else {
                              selectedDay = value;
                              consultationController.days[widget.index].day = value;
                            } /*else if (consultationController.days.where((element) => element.day == "").isNotEmpty) {
                              consultationController.days.add(SlotData());
                            }*/
                            consultationController.update();
                            log("${consultationController.days[widget.index]}", name: "onChanged");
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (consultationController.days.length != 1) {
                            consultationController.days.removeAt(widget.index);
                            consultationController.update();
                          }
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 8,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.2,
                    ),
                    itemBuilder: (context, int index) {
                      DateTime currentTime = time.add(Duration(minutes: 30 * (index)));
                      bool selectedSlot = false;
                      // if (consultationController.days.length > 1) {
                      selectedSlot = consultationController.days[widget.index].slotArray.contains(SlotArray(position: index, time: currentTime));
                      // }
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              try {
                                if (selectedSlot) {
                                  consultationController.days[widget.index].slotArray.removeWhere((element) => element.time == currentTime);
                                  // selected.remove(currentTime);
                                } else {
                                  consultationController.days[widget.index].slotArray.add(SlotArray(time: currentTime, position: index));
                                }
                                consultationController.update();
                              } catch (e) {
                                log("$e");
                              }
                              /*setState(() {});*/
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                color: selectedSlot ? Theme.of(context).primaryColor : null,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Center(
                                child: Text(
                                  hMA.format(currentTime),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.0,
                                    color: selectedSlot ? Colors.white : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
