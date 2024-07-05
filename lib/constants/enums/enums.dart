enum UserTypes {
  admin,
  //other,
  auditor,
  spcb,
  inspection,
  producer,
  retreader,
  recycler,
  custom;
}

enum SalesDataDropdown { producerType, typeOfTyre, financialYear, month }

enum RecyclerProcurementDataDropdown {
  financialYear,
  typeOfRawMaterial,
  tyreSource
}

enum AdminUserTypes {
  producer('producer'),
  recycler('recycler'),
  retreader('retreader');

  const AdminUserTypes(this.text);
  final String text;
}

enum AuditorStatus {
  acknowledge('Acknowledge'),
  start('Start'),
  viewReport('View Report'),
  resume("Continue");

  const AuditorStatus(this.text);
  final String text;
}

enum AuditorProducerForm1 {
  gst('gst'),
  panOfCompany("panOfCompany"),
  cin("cin"),
  iec("iec");

  const AuditorProducerForm1(this.text);
  final String text;
}
