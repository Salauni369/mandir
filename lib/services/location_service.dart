
class LocationService {
  static String? selectedPlace;

  static void setLocation(String place) {
    selectedPlace = place;
  }

  static String? getLocation() => selectedPlace;
}