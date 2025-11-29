class LocationModel {
  String address;
  String area;
  String pincode;
  String city;
  double? latitude;
  double? longitude;

  LocationModel({
    required this.address,
    required this.area,
    required this.pincode,
    required this.city,
    this.latitude,
    this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> j) => LocationModel(
    address: j['address'] ?? '',
    area: j['area'] ?? '',
    pincode: j['pincode'] ?? '',
    city: j['city'] ?? '',
    latitude: j['latitude'] != null ? (j['latitude'] as num).toDouble() : null,
    longitude: j['longitude'] != null ? (j['longitude'] as num).toDouble() : null,
  );

  Map<String, dynamic> toJson() => {
    'address': address,
    'area': area,
    'pincode': pincode,
    'city': city,
    'latitude': latitude,
    'longitude': longitude,
  };
}
