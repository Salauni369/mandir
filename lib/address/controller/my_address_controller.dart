// import 'package:get/get.dart';
//
// class MyAddressController extends GetxController {
//   final DioHelper _dioHelper = DioHelper();
//
//   /// 🔹 Loading state
//   final RxBool isLoading = false.obs;
//
//   /// 🔹 Add or Edit Address API
//   Future<void> addAndEditAddressApi({
//     required String pageType,
//     required String addressId,
//     required String type,
//     required String deliveryTime,
//     required String firstName,
//     required String country,
//     required String addressLine1,
//     required String latitude,
//     required String longitude,
//     required String mobile,
//     required String flat,
//     required String landmark,
//     required String city,
//     required String state,
//     required String zipCode,
//     required bool isDefault,
//   }) async {
//     try {
//       isLoading.value = true; // ⏳ Show loader
//
//       final response = await _dioHelper.putApi(
//         url: pageType == "edit"
//             ? ApiConstants.EDIT_ADDRESS_API
//             : ApiConstants.ADD_ADDRESS_API,
//         reqBody: {
//           if (pageType == "edit") "addAddressId": addressId,
//           "types": type.toLowerCase(),
//           "deliveryTime": deliveryTime,
//           "firstName": firstName,
//           "country": country,
//           "addressLine1": addressLine1,
//           "latitude": latitude,
//           "longitude": longitude,
//           "mobile": mobile,
//           "flat": flat,
//           "landmark": landmark,
//           "city": city,
//           "state": state,
//           "zipCode": zipCode,
//           "isDefault": isDefault,
//         },
//         isAuthRequired: true,
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         AnimationSnackBar.openTopSnackBar(
//           message: response.data["message"]?.toString() ?? "Address saved successfully",
//           type: SnackBarType.success,
//         );
//       } else {
//         AnimationSnackBar.openTopSnackBar(
//           message: response.data["message"]?.toString() ?? "Something went wrong",
//           type: SnackBarType.error,
//         );
//       }
//     } catch (e) {
//       customPrint("❌ Add/Edit Address API Error: $e");
//       AnimationSnackBar.openTopSnackBar(
//         message: "Failed to save address. Please try again.",
//         type: SnackBarType.error,
//       );
//     } finally {
//       isLoading.value = false; // ✅ Hide loader
//     }
//   }
//
//   /// 🔹 Delete Address API
//   Future<void> deleteAddressApi(String addressId) async {
//     try {
//       isLoading.value = true;
//
//       final response = await _dioHelper.deleteApi(
//         url: "${ApiConstants.DELETE_ADDRESS_API}/$addressId",
//         isAuthRequired: true,
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         AnimationSnackBar.openTopSnackBar(
//           message: response.data["message"]?.toString() ??
//               "Address deleted successfully",
//           type: SnackBarType.success,
//         );
//       }
//     } catch (e) {
//       customPrint("❌ Delete Address API Error: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// 🔹 Set as Default Address API
//   Future<void> setAsDefaultAddressApi(String addressId) async {
//     try {
//       isLoading.value = true;
//
//       final response = await _dioHelper.putApi(
//         url: "${ApiConstants.SET_DEFAULT_ADDRESS_API}/$addressId",
//         isAuthRequired: true,
//         reqBody: {"isDefault": true},
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         customPrint(response.data["message"]?.toString() ?? "Address set as default");
//       }
//     } catch (e) {
//       customPrint("❌ Set Default Address API Error: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
