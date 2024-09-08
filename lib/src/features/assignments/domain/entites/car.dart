class Car {
  String? make;
  String? model;
  String? color;
  String? licensePlate;

  Car({
    this.make,
    this.model,
    this.color,
    this.licensePlate,
  });

  @override
  List<Object?> get props => [make, model, color, licensePlate];
}
