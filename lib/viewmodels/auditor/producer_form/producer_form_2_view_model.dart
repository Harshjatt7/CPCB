import 'package:cpcb_tyre/constants/string_constant.dart';

import '../../base_viewmodel.dart';

class ProducerForm2ViewModel extends BaseViewModel {
  final stringConstants = StringConstants();
  String radioMisreportingP1 = "";
  String radioMisreportingP3 = "";
  
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
