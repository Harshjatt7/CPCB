import 'dart:convert';

String producerAddSalesRequestModelToJson(ProducerAddSalesRequestModel data) => json.encode(data.toJson());

class ProducerAddSalesRequestModel {
    String? producerType;
    String? typeOfTyreManufacture;
    String? financialYear;
    num? month;
    num? motorCycle;
    num? passengerCar;
    num? scooter;
    num? truck;
    num? bus;
    num? lcv;
    num? tRear;
    num? other;
    num? total;

    ProducerAddSalesRequestModel({
        this.producerType,
        this.typeOfTyreManufacture,
        this.financialYear,
        this.month,
        this.motorCycle,
        this.passengerCar,
        this.scooter,
        this.truck,
        this.bus,
        this.lcv,
        this.tRear,
        this.other,
        this.total,
    });

    Map<String, dynamic> toJson() => {
        "producer_type": producerType,
        "type_of_tyre_manufacture": typeOfTyreManufacture,
        "financial_year": financialYear,
        "month": month,
        "motor_cycle": motorCycle,
        "passenger_car": passengerCar,
        "scooter": scooter,
        "truck": truck,
        "bus": bus,
        "lcv": lcv,
        "t_rear": tRear,
        "other": other,
        "total": total,
    };
}
