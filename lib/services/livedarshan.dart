// // lib/services/darshan_service.dart
//
// import '../models/live_darshan_model.dart';
//
// class DarshanService {
//   static List<DarshanModel> mockDarshans = [
//     DarshanModel(
//       id: "1",
//       title: "ISKCON Krishna Janmashtami Celebration Live Darshan",
//       templeName: "ISKCON Temple Vrindavan",
//       liveLink: "https://youtube.com/watch?v=gryj264eu",
//       webImage: "https://picsum.photos/600/400?random=1",
//       mobileImage: "https://picsum.photos/400/600?random=1",
//       createdAt: DateTime.now().subtract(Duration(days: 2)),
//       isLive: true, description: '', subtitle: '', image: '',
//     ),
//     // Add more mock data...
//   ];
//
//   static Future<List<DarshanModel>> getAll() async {
//     await Future.delayed(Duration(seconds: 1));
//     return mockDarshans;
//   }
//
//   static Future<void> add(DarshanModel darshan) async {
//     await Future.delayed(Duration(seconds: 2));
//     mockDarshans.insert(0, darshan..id = DateTime.now().toString());
//   }
//
//   static Future<void> update(DarshanModel darshan) async {
//     await Future.delayed(Duration(seconds: 2));
//     final index = mockDarshans.indexWhere((e) => e.id == darshan.id);
//     if (index != -1) mockDarshans[index] = darshan;
//   }
//
//   static Future<void> delete(String id) async {
//     await Future.delayed(Duration(seconds: 1));
//     mockDarshans.removeWhere((e) => e.id == id);
//   }
// }



// lib/services/darshan_service.dart

import '../models/live_darshan_model.dart';

class DarshanService {
  static List<DarshanModel> mockDarshans = [
    DarshanModel(
      id: "1",
      title: "ISKCON Krishna Janmashtami Celebration Live Darshan",
      templeName: "ISKCON Temple Vrindavan",
      liveLink: "https://youtube.com/watch?v=gryj264eu",
      webImage: "https://picsum.photos/600/400?random=1",
      mobileImage: "https://picsum.photos/400/600?random=1",
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      isLive: true,
      description: "Live darshan of ISKCON Janmashtami event",
      subtitle: "Special Celebration",
      image: "https://picsum.photos/500/300?random=55",
    ),
  ];

  /// Get all darshans
  static Future<List<DarshanModel>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return mockDarshans;
  }

  /// Add new darshan
  static Future<void> add(DarshanModel darshan) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    final item = darshan.copyWith(id: newId);

    mockDarshans.insert(0, item);
  }

  /// Update existing darshan
  static Future<void> update(DarshanModel darshan) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final index = mockDarshans.indexWhere((e) => e.id == darshan.id);
    if (index != -1) {
      mockDarshans[index] = darshan;
    }
  }

  /// Delete darshan
  static Future<void> delete(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    mockDarshans.removeWhere((e) => e.id == id);
  }
}
