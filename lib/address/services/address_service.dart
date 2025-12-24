// import 'package:http/http.dart';
// import 'package:get/get.dart';
//
// import '../../apiservices/api_services.dart';
// import '../models/saved_address_models.dart';
//
// class AddressService {
//   static final AddressService _instance = AddressService._internal();
//   factory AddressService() => _instance;
//   AddressService._internal();
//
//   final ApiService _apiService = ApiService();
//
//
//   // Get saved addresses
//   Future<SavedAddressResponse> getSavedAddresses() async {
//     return _apiService.get<SavedAddressResponse>(
//       Endpoints.getAddress,
//       headers: {
//         'Authorization': AuthHelper.getAuthToken,
//       },
//       parser: (data) => SavedAddressResponse.fromJson(
//         data as Map<String, dynamic>,
//       ),
//     );
//   }
// }