class Car {
  String? make;
  String? model;
  String? color;
  String? licensePlate;
  String? vinNumber;

  Car({
    this.make,
    this.model,
    this.color,
    this.licensePlate,
    this.vinNumber,
  });

  @override
  List<Object?> get props => [make, model, color, licensePlate, vinNumber];
}
