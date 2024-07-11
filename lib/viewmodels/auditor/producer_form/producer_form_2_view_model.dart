import 'package:cpcb_tyre/constants/string_constant.dart';

import '../../base_viewmodel.dart';

class ProducerForm2ViewModel extends BaseViewModel {
  final stringConstants = StringConstants();
  String radioMisreportingP1 = "confirmed";
  String radioMisreportingP3 = "confirmed";
  
  List<String> producerHeadingList = [
    "Type of Tyre",
    "Financial Year",
    "Motorcycle",
    "Passenger Car",
    "Scooter",
    "Truck",
    "Bus",
    "LCV",
    "T Rear",
    "Other",
    "Total"
  ];
}
