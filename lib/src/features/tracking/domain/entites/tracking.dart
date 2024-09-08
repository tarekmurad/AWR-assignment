import 'package:aw_rostamani/src/features/tracking/domain/entites/vendor.dart';

import 'car.dart';
import 'customer.dart';
import 'location.dart';

class Tracking {
  int? id;
  String? ref;
  Customer? customer;
  Vendor? vendor;
  Car? car;
  String? status;
  String? type;
  Location? sourceLocation;
  Location? destinationLocation;

  Tracking({
    this.id,
    this.ref,
    this.customer,
    this.vendor,
    this.car,
    this.status,
    this.type,
    this.sourceLocation,
    this.destinationLocation,
  });

  @override
  List<Object?> get props => [
        id,
        customer,
        vendor,
        ref,
        type,
        car,
        status,
        sourceLocation,
        destinationLocation
      ];
}
