class PlaceDetails {
  final String name;
  final String formattedAddress;
  final double latitude;
  final double longitude;
  final List<AddressComponent> addressComponents;

  PlaceDetails({
    required this.name,
    required this.formattedAddress,
    required this.latitude,
    required this.longitude,
    required this.addressComponents,
  });

  factory PlaceDetails.fromGooglePlace(Map<String, dynamic> json) {
    final geometry = json['geometry'] ?? {};
    final location = geometry['location'] ?? {};
    final latValue = location['lat'];
    final lngValue = location['lng'];

    final double latitude = latValue is num
        ? latValue.toDouble()
        : double.tryParse(latValue?.toString() ?? '') ?? 0.0;

    final double longitude = lngValue is num
        ? lngValue.toDouble()
        : double.tryParse(lngValue?.toString() ?? '') ?? 0.0;

    return PlaceDetails(
      name: json['name']?.toString() ??
          json['formatted_address']?.toString() ??
          '',
      formattedAddress: json['formatted_address']?.toString() ?? '',
      latitude: latitude,
      longitude: longitude,
      addressComponents: (json['address_components'] as List?)
          ?.map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}

class AddressComponent {
  final String longName;
  final String shortName;
  final List<String> types;

  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longName: json['long_name']?.toString() ?? '',
      shortName: json['short_name']?.toString() ?? '',
      types: (json['types'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
