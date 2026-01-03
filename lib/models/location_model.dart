// 🔥 ADD THIS TO YOUR LocationModel CLASS

class LocationModel {
  final String address;
  final String area;
  final String pincode;
  final String city;
  final String state;

  LocationModel({
    required this.address,
    required this.area,
    required this.pincode,
    required this.city,
    required this.state,
  });

  // 🔥 ADD THIS COPYWITH METHOD
  LocationModel copyWith({
    String? address,
    String? area,
    String? pincode,
    String? city,
    String? state,
  }) {
    return LocationModel(
      address: address ?? this.address,
      area: area ?? this.area,
      pincode: pincode ?? this.pincode,
      city: city ?? this.city,
      state: state ?? this.state,
    );
  }
}