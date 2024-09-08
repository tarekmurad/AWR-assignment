class Vendor {
  String? name;
  String? id;
  String? phone;
  String? email;
  String? company;

  Vendor({
    this.name,
    this.id,
    this.phone,
    this.email,
    this.company,
  });

  @override
  List<Object?> get props => [name, id, phone, email, company];
}
