import 'package:latlong2/latlong.dart';

class Geo {
  final LatLng latLng;
  final String? address;

  const Geo({
    required this.latLng,
    this.address,
  });
}
