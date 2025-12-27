// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:zamboree_devotion/address/view/widgets/place_details.dart';
// import '../models/location_suggestion.dart';
//
// class PlacesApiService {
//   static const String _baseUrl = 'https://maps.googleapis.com/maps/api';
//   static const String _apiKey = 'AIzaSyB3WYl5SI0IEo4QvpssbCfNiFz9NlbjhBc';
//
//   static const int _defaultRadiusMeters = 50000;
//
//   /// 🔹 Autocomplete suggestions
//   Future<List<LocationSuggestion>> getAutocompleteSuggestions({
//     required String input,
//     String? sessionToken,
//     double? latitude,
//     double? longitude,
//     int? radius,
//     List<String>? types,
//     String? components,
//   }) async {
//     if (input.trim().isEmpty) return [];
//
//     try {
//       final queryParams = <String, String>{
//         'input': input,
//         'key': _apiKey,
//         'language': "en", // ✅ Always English
//       };
//
//       if (sessionToken != null) queryParams['sessiontoken'] = sessionToken;
//       if (latitude != null && longitude != null) {
//         queryParams['location'] = '$latitude,$longitude';
//         queryParams['radius'] = (radius ?? _defaultRadiusMeters).toString();
//       }
//       if (types != null && types.isNotEmpty) {
//         queryParams['types'] = types.join('|');
//       }
//       if (components != null) {
//         queryParams['components'] = components;
//       }
//
//       final uri = Uri.parse('$_baseUrl/place/autocomplete/json')
//           .replace(queryParameters: queryParams);
//
//       final response = await http.get(uri).timeout(const Duration(seconds: 10));
//       final data = json.decode(response.body);
//
//       if (response.statusCode == 200 && data['status'] == 'OK') {
//         final predictions = data['predictions'] as List;
//         return predictions
//             .map((p) => LocationSuggestion.fromGooglePlace(p))
//             .toList();
//       } else {
//         throw Exception('Places API error: ${data['status']}');
//       }
//     } catch (e) {
//       throw Exception('Failed to get autocomplete suggestions: $e');
//     }
//   }
//
//   /// 🔹 Place details by ID
//   Future<PlaceDetails> getPlaceDetails({
//     required String placeId,
//     String? sessionToken,
//     List<String>? fields,
//   }) async {
//     try {
//       final queryParams = <String, String>{
//         'place_id': placeId,
//         'key': _apiKey,
//         'language': "en",
//         'fields': (fields?.isNotEmpty ?? false)
//             ? fields!.join(',')
//             : [
//           'place_id',
//           'name',
//           'formatted_address',
//           'geometry/location',
//           'address_component',
//           'types',
//           'vicinity',
//           'url',
//           'website',
//           'formatted_phone_number',
//           'rating',
//           'user_ratings_total'
//         ].join(','),
//       };
//
//       if (sessionToken != null) queryParams['sessiontoken'] = sessionToken;
//
//       final uri = Uri.parse('$_baseUrl/place/details/json')
//           .replace(queryParameters: queryParams);
//
//       final response = await http.get(uri).timeout(const Duration(seconds: 10));
//       final data = json.decode(response.body);
//
//       if (response.statusCode == 200 && data['status'] == 'OK') {
//         return PlaceDetails.fromJson(data['result']);
//       } else {
//         throw Exception('Places API error: ${data['status']}');
//       }
//     } catch (e) {
//       throw Exception('Failed to get place details: $e');
//     }
//   }
//
//   /// 🔹 Nearby places
//   Future<List<PlaceDetails>> getNearbyPlaces({
//     required double latitude,
//     required double longitude,
//     int radius = _defaultRadiusMeters,
//     String? type,
//     String? keyword,
//     int? maxResults,
//   }) async {
//     try {
//       final queryParams = <String, String>{
//         'location': '$latitude,$longitude',
//         'radius': radius.toString(),
//         'key': _apiKey,
//         'language': "en",
//       };
//
//       if (type != null) queryParams['type'] = type;
//       if (keyword != null) queryParams['keyword'] = keyword;
//
//       final uri = Uri.parse('$_baseUrl/place/nearbysearch/json')
//           .replace(queryParameters: queryParams);
//
//       final response = await http.get(uri).timeout(const Duration(seconds: 10));
//       final data = json.decode(response.body);
//
//       if (response.statusCode == 200 && data['status'] == 'OK') {
//         final results = data['results'] as List;
//         var places =
//         results.map((r) => PlaceDetails.fromJson(r)).toList();
//
//         if (maxResults != null && places.length > maxResults) {
//           places = places.take(maxResults).toList();
//         }
//
//         return places;
//       } else {
//         throw Exception('Places API error: ${data['status']}');
//       }
//     } catch (e) {
//       throw Exception('Failed to get nearby places: $e');
//     }
//   }
//
//   /// 🔹 Reverse geocoding
//   Future<List<PlaceDetails>> reverseGeocode({
//     required double latitude,
//     required double longitude,
//     List<String>? resultTypes,
//   }) async {
//     try {
//       final queryParams = <String, String>{
//         'latlng': '$latitude,$longitude',
//         'key': _apiKey,
//         'language': "en",
//       };
//       print("query =>> ${queryParams}");
//       if (resultTypes != null && resultTypes.isNotEmpty) {
//         queryParams['result_type'] = resultTypes.join('|');
//       }
//
//       final uri =
//       Uri.parse('$_baseUrl/geocode/json').replace(queryParameters: queryParams);
//
//       final response = await http.get(uri).timeout(const Duration(seconds: 10));
//       final data = json.decode(response.body);
//
//       if (response.statusCode == 200 && data['status'] == 'OK') {
//         final results = data['results'] as List;
//         return results
//             .map((result) => PlaceDetails.fromJson(result))
//             .toList();
//       } else {
//         throw Exception('Geocoding API error: ${data['status']}');
//       }
//     } catch (e) {
//       throw Exception('Failed to reverse geocode: $e');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../address/view/widgets/place_details.dart';
import '../models/location_suggestion.dart';

class PlacesApiService {
  // ⚠️ IMPORTANT: Replace with your actual API key
  final String _apiKey = 'AIzaSyB3WYl5SI0IEo4QvpssbCfNiFz9NlbjhBc';

  // 🔹 Autocomplete Suggestions
  Future<List<LocationSuggestion>> getAutocompleteSuggestions({
    required String input,
    required double latitude,
    required double longitude,
    int radius = 50000,
    String components = 'country:in',
  }) async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json'
            '?input=$input'
            '&location=$latitude,$longitude'
            '&radius=$radius'
            '&components=$components'
            '&key=$_apiKey',
      );

      print("🌐 Autocomplete URL: $url");

      final response = await http.get(url);

      print("📦 Autocomplete Response Status: ${response.statusCode}");
      print("📦 Autocomplete Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final predictions = data['predictions'] as List<dynamic>;

          return predictions.map((prediction) {
            return LocationSuggestion(
              placeId: prediction['place_id'] ?? '',
              description: prediction['description'] ?? '',
              mainText: prediction['structured_formatting']?['main_text'] ?? '',
              secondaryText: prediction['structured_formatting']?['secondary_text'] ?? '', types: [],
            );
          }).toList();
        } else {
          print("⚠️ API Status: ${data['status']}");
          print("⚠️ Error Message: ${data['error_message']}");
          throw Exception('Places API error: ${data['status']}');
        }
      } else {
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Autocomplete error: $e");
      rethrow;
    }
  }

  // 🔹 Get Place Details
  Future<PlaceDetails> getPlaceDetails({required String placeId}) async {
    if (placeId.isEmpty) {
      throw Exception('Place ID is empty');
    }

    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json'
            '?place_id=$placeId'
            '&key=$_apiKey',
      );

      print("🌐 Place Details URL: $url");

      final response = await http.get(url);

      print("📦 Place Details Response Status: ${response.statusCode}");
      print("📦 Place Details Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final result = data['result'];
          return PlaceDetails.fromGooglePlace(result);
        } else {
          print("⚠️ API Status: ${data['status']}");
          print("⚠️ Error Message: ${data['error_message']}");
          throw Exception('Places API error: ${data['status']}');
        }
      } else {
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Place details error: $e");
      throw Exception('Failed to get place details: $e');
    }
  }

  // 🔹 Reverse Geocode
  Future<List<PlaceDetails>> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json'
            '?latlng=$latitude,$longitude'
            '&key=$_apiKey'
            '&language=en',
      );

      print("🌐 Reverse Geocode URL: $url");

      final response = await http.get(url);

      print("📦 Reverse Geocode Response Status: ${response.statusCode}");
      // Don't print full body as it's too large, just status

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print("📦 Geocode Status: ${data['status']}");

        if (data['status'] == 'OK') {
          final results = data['results'] as List<dynamic>;

          print("📍 Total results: ${results.length}");

          if (results.isNotEmpty) {
            // Print first result for debugging
            print("📮 First result name: ${results[0]['name'] ?? results[0]['formatted_address']}");
            print("📮 First result address: ${results[0]['formatted_address']}");
          }

          return results.map((result) {
            final geometry = result['geometry'];
            final location = geometry['location'];

            return PlaceDetails(
              placeId: result['place_id'] ?? '',
              name: result['name'] ?? '',
              formattedAddress: result['formatted_address'] ?? '',
              latitude: (location['lat'] as num).toDouble(),
              longitude: (location['lng'] as num).toDouble(),
              types: List<String>.from(result['types'] ?? []),
              vicinity: result['vicinity'],
            );
          }).toList();
        } else {
          print("⚠️ Geocode API Status: ${data['status']}");
          print("⚠️ Error Message: ${data['error_message']}");
          throw Exception('Geocode API error: ${data['status']}');
        }
      } else {
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Reverse geocode error: $e");
      rethrow;
    }
  }
}
