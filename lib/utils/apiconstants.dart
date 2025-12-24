

class ApiConstants {
  // BASE URL
  //https://api.gamsgroup.in
  //https://geri-euphuistic-unstridently.ngrok-free.dev
  //static const String baseUrl = "https://geri-euphuistic-unstridently.ngrok-free.dev";
  static const String baseUrl= "https://api.gamsgroup.in";

  // AUTH
  static const String sendOtp = "$baseUrl/spiritual/auth/send-otp";
  static const String verifyOtp = "$baseUrl/spiritual/auth/verify-otp";

  // DASHBOARD / LIVE
  static const String dashboard = "$baseUrl/spiritual/temple";
  static const String liveDarshan = "$baseUrl/spiritual/live";
  static const String getdonation = "$baseUrl/spiritual/donation";
  static const String postdonation = "$baseUrl/spiritual/donation";
  static const String updateOverview  = "$baseUrl/spiritual/temple/overview";
  static const String buffer      = "$baseUrl/spiritual/buffer";
}
