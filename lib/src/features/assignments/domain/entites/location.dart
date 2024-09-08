class Location {
  double? lat;
  double? long;
  String? addressNotes;

  Location({
    this.lat,
    this.long,
    this.addressNotes,
  });

  @override
  List<Object?> get props => [lat, long, addressNotes];
}
