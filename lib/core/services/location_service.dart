import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nuli_app/core/constants/app_constans.dart';

class LocationService {
  LocationService();

  Position? _cachedPosition;
  String? _cachedLabel;

  Future<Position> getCurrentPosition({
    LocationAccuracy accuracy = LocationAccuracy.medium,
  }) async{
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.denied) {
    throw Exception('Location permission denied.');
  }
  _cachedPosition ??= await Geolocator.getCurrentPosition(
    desiredAccuracy: accuracy,
    timeLimit: AppConstants.requestTimeout,
  );
  return _cachedPosition!;
 }

 Future<String> getLocationLabelFrom( Position position) async {
    if(_cachedLabel != null) return _cachedLabel!;

    final placemark = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
    );
    if (placemark.isEmpty){
      return 'Vị trí không xác định';
    }

    final place = placemark.first;

    final parts = <String>[
      if ((place.locality ?? '').isNotEmpty) place.locality!,
      if ((place.administrativeArea ?? '').isNotEmpty)
        place.administrativeArea!,
      if ((place.country ?? '').isNotEmpty) place.country!,
    ];

      _cachedLabel = parts.join(', ');
      return _cachedLabel!;
 }
  Future<String> getCurrentLocationLabel() async {
    final position = await getCurrentPosition();
    return getLocationLabelFrom(position);
  }
  void clearCache() {
    _cachedPosition = null;
    _cachedLabel = null;
  }

}