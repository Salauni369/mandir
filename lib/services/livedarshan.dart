// // lib/services/api_service.dart
// import 'package:dio/dio.dart';
// import '../models/live_darshan_model.dart';
//
// class ApiService {
//   static final Dio _dio = Dio();
//
//   static Future<List<LiveDarshanModel>> fetchLiveDarshans() async {
//     // REAL API CALL (Future mein yaha se aayega)
//     // final response = await _dio.get("https://api.iskconapp.com/darshan");
//     // return (response.data as List).map((e) => LiveDarshanModel.fromJson(e)).toList();
//
//     // ABHI KE LIYE MOCK DATA
//     await Future.delayed(const Duration(seconds: 1));
//     return [
//       LiveDarshanModel(
//         id: "1",
//         title: "ISKCON Krishna Janmashtami Celebration Live Darshan from Vrindavan",
//         image: "https://images.unsplash.com/photo-1599481241901-8d9e0e1e0e2f?w=800&q=80",
//         youtubeLink: "https://youtube.com/live/janmashtami2025",
//         isLive: true,
//       ),
//       LiveDarshanModel(
//         id: "2",
//         title: "ISKCON Krishna Janmashtami Celebration Live Darshan from Vrindavan",
//         image: "https://images.unsplash.com/photo-1599481241901-8d9e0e1e0e2f?w=800&q=80",
//         youtubeLink: "https://youtube.com/live/janmashtami2025",
//         isLive: true,
//       ),
//       LiveDarshanModel(
//         id: "3",
//         title: "ISKCON Krishna Janmashtami Celebration Live Darshan from Vrindavan",
//         image: "https://images.unsplash.com/photo-1599481241901-8d9e0e1e0e2f?w=800&q=80",
//         youtubeLink: "https://youtube.com/live/janmashtami2025",
//         isLive: false,
//         endedOn: "4th November, 2025",
//       ),
//       LiveDarshanModel(
//         id: "4",
//         title: "ISKCON Krishna Janmashtami Celebration Live Darshan from Vrindavan",
//         image: "https://images.unsplash.com/photo-1599481241901-8d9e0e1e0e2f?w=800&q=80",
//         youtubeLink: "https://youtube.com/live/janmashtami2025",
//         isLive: false,
//         endedOn: "4th November, 2025",
//       ),
//     ];
//   }
// }