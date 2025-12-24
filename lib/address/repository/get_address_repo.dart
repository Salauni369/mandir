// import 'package:zamboree/common/constant/api_constants.dart';
// import 'package:zamboree/features/quiz/presentation/data_converter/data_decode.dart';
// import 'package:zamboree/utils/api_manager/dio_helper.dart';
// import '../models/get_address_model.dart';
//
// class GetAddressRepository {
//   final DioHelper _dioHelper = DioHelper();
//
//   /// Fetch leaderboard data
//   Future<GetAddressModel> fetchAddressRepo() async {
//     try {
//       final response = await _dioHelper.getApi(
//         url: ApiConstants.GET_ADDRESS_API,
//         isAuthRequired: true,
//       );
//
//       final Map<String, dynamic> jsonData = ResponseParser.parseResponseData(response.data);
//       return GetAddressModel.fromJson(jsonData);
//     } catch (e) {
//       rethrow;
//     }
//   }
//
// }
