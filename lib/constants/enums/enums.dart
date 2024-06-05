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
