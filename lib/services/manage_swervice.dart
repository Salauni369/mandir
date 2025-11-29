// Replace with real HTTP/Dio calls when backend ready.
// For now this file documents where to put network logic.

import '../models/location_model.dart';
import '../models/social_media.dart';

import '../models/timming_model.dart';

class ManageService {
  // Example stubs:
  static Future<void> updateTempleDetails({
    required String name,
    required String about,
    required String contact,
    required LocationModel location,
    required List<TimingModel> darshan,
    required List<TimingModel> aarti,
    required List<SocialModel> socials,
    required List<String> gallery,
  }) async {
    // Implement API call
    await Future.delayed(const Duration(milliseconds: 300));
  }

// Add actual fetch/update API methods as needed
}
