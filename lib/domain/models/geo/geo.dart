import 'package:latlong2/latlong.dart';

class Geo {
  final LatLng latLng;
  final String? address;

  const Geo({
    required this.latLng,
    this.address,
  });

  static Geo fromJson(dynamic source) {
    return Geo(
      latLng: LatLng(source['latitude'], source['longitude']),
      address: source['address'],
    );
  }
}
