import 'car.dart';
import 'customer.dart';
import 'location.dart';

class Assignment {
  int? id;
  String? ref;
  Customer? customer;
  Car? car;
  String? status;
  String? type;
  Location? sourceLocation;
  Location? destinationLocation;

  Assignment({
    this.id,
    this.ref,
    this.customer,
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
        ref,
        type,
        car,
        status,
        sourceLocation,
        destinationLocation
      ];
}
