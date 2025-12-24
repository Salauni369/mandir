class GetAddressModel {
  int? statusCode;
  List<AddressData>? data;
  String? message;
  bool? success;

  GetAddressModel({
    this.statusCode,
    this.data,
    this.message,
    this.success,
  });

  factory GetAddressModel.fromJson(Map<String, dynamic> json) {
    return GetAddressModel(
      statusCode: json["statusCode"] != null
          ? int.tryParse(json["statusCode"].toString())
          : null,
      data: json["data"] != null
          ? (json["data"] as List)
          .map((x) => AddressData.fromJson(x as Map<String, dynamic>))
          .toList()
          : null,
      message: json["message"]?.toString(),
      success: json["success"] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "data": data?.map((e) => e.toJson()).toList(),
      "message": message,
      "success": success,
    };
  }
}

class AddressData {
  String? types;
  String? deliveryTime;
  String? firstName;
  String? addressLine1;
  String? latitude;
  String? longitude;
  int? mobile;
  String? flat;
  String? landmark;
  String? zipCode;
  bool? isDefault;
  String? id;

  // 🔹 Add distance property
  double? distanceInKm;

  AddressData({
    this.types,
    this.deliveryTime,
    this.firstName,
    this.addressLine1,
    this.latitude,
    this.longitude,
    this.mobile,
    this.flat,
    this.landmark,
    this.zipCode,
    this.isDefault,
    this.id,
    this.distanceInKm,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      types: json["types"]?.toString(),
      deliveryTime: json["deliveryTime"]?.toString(),
      firstName: json["firstName"]?.toString(),
      addressLine1: json["addressLine1"]?.toString(),
      latitude: json["latitude"]?.toString(),
      longitude: json["longitude"]?.toString(),
      mobile: json["mobile"] != null
          ? int.tryParse(json["mobile"].toString())
          : null,
      flat: json["flat"]?.toString(),
      landmark: json["landmark"]?.toString(),
      zipCode: json["zipCode"]?.toString(),
      isDefault: json["isDefault"] as bool?,
      id: json["_id"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "types": types,
      "deliveryTime": deliveryTime,
      "firstName": firstName,
      "addressLine1": addressLine1,
      "latitude": latitude,
      "longitude": longitude,
      "mobile": mobile,
      "flat": flat,
      "landmark": landmark,
      "zipCode": zipCode,
      "isDefault": isDefault,
      "_id": id,
    };
  }
}
