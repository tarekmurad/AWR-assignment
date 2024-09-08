class Customer {
  String? name;
  String? id;
  String? phone;
  String? email;
  String? address;

  Customer({
    this.name,
    this.id,
    this.phone,
    this.email,
    this.address,
  });

  @override
  List<Object?> get props => [name, id, phone, email, address];
}
