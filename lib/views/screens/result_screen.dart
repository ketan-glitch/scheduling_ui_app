import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:scheduling_ui_app/controllers/controller.dart';
import 'package:scheduling_ui_app/views/screens/home_screen.dart';

import '../../data/models/slot_data.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  printTime(SlotData element) {
    var sad = '';
    for (var element in element.slotArray) {
      sad += "${hMA.format(element.time!)}, ";
    }
    return sad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ConsultationController>(builder: (consultationController) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var element in consultationController.days)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${element.day} : ${element.slotArray}",
                      ),
                      // Text(
                      //   "${element.day} : ${printTime(element)}",
                      // ),
                    ],
                  ),
                )
            ],
          );
        }),
      ),
    );
  }
}
