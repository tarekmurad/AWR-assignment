class Customer {
  String? name;
  String? id;
  String? phone;
  String? email;

  Customer({
    this.name,
    this.id,
    this.phone,
    this.email,
  });

  @override
  List<Object?> get props => [name, id, phone, email];
}
