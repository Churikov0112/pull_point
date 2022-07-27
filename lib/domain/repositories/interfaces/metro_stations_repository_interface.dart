import 'package:latlong2/latlong.dart';

import '../../models/models.dart';

abstract class MetroStationsRepositoryInterface {
  List<MetroStationModel> getAllMetroStations();

  List<MetroStationModel> getNearestMetroStations({
    required LatLng latLng,
  });
}
