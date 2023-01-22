import 'package:get/get.dart';

import '../data/models/slot_data.dart';

class ConsultationController extends GetxController implements GetxService {
  List<SlotData> days = [
    SlotData(
      day: null,
      slotArray: [],
    ),
  ];

  checkIfDayIsPresent() {}
}
