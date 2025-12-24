


import 'package:get_storage/get_storage.dart';

class ApiHeaders {
  static final _box = GetStorage();

  static Map<String, String> headers() {
    final token = _box.read("access_token");
    print("token === >>> $token");
    //final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2OTI4MmE1MmUzMmZkMmU2NjU5ODNiNTciLCJwaG9uZSI6OTYzOTg1MDE0MSwiaWF0IjoxNzY1Nzk3MTkyLCJleHAiOjE3NjU4ODM1OTJ9.u24Lxku0_LwQaHRfUm1FJECUj8w4dMKxt2K-I7lcRHI';

    return {
      "Content-Type": "application/json",
      if (token != null && token.toString().isNotEmpty)
        "Authorization": "Bearer $token",
    };
  }
}
