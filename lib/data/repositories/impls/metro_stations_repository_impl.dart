import 'dart:math';
import 'package:latlong2/latlong.dart';
import '../../../domain/models/models.dart';

class MetroStations {
  static _degreesToRadians(degrees) {
    return degrees * pi / 180;
  }

  static _distanceInKmBetweenEarthCoordinates(lat1, lon1, lat2, lon2) {
    var earthRadiusKm = 6371;

    var dLat = _degreesToRadians(lat2 - lat1);
    var dLon = _degreesToRadians(lon2 - lon1);

    lat1 = _degreesToRadians(lat1);
    lat2 = _degreesToRadians(lat2);

    var a = sin(dLat / 2) * sin(dLat / 2) + sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  // use as const
  static final List<MetroStationModel> _allMetroStations = [
    // красная ветка
    MetroStationModel(id: 0, title: "Проспект Ветеранов", latLng: LatLng(59.84188, 30.251543), line: MetroLines.firstRed),
    MetroStationModel(id: 1, title: "Ленинский проспект", latLng: LatLng(59.851677, 30.268279), line: MetroLines.firstRed),
    MetroStationModel(id: 2, title: "Автово", latLng: LatLng(59.867369, 30.261345), line: MetroLines.firstRed),
    MetroStationModel(id: 3, title: "Кировский завод", latLng: LatLng(59.879726, 30.261908), line: MetroLines.firstRed),
    MetroStationModel(id: 4, title: "Нарвская", latLng: LatLng(59.901169, 30.274676), line: MetroLines.firstRed),
    MetroStationModel(id: 5, title: "Балтийская", latLng: LatLng(59.907245, 30.299217), line: MetroLines.firstRed),
    MetroStationModel(id: 6, title: "Технологический институт-1", latLng: LatLng(59.916799, 30.318967), line: MetroLines.firstRed),
    MetroStationModel(id: 7, title: "Пушкинская", latLng: LatLng(59.920757, 30.329641), line: MetroLines.firstRed),
    MetroStationModel(id: 8, title: "Владимирская", latLng: LatLng(59.927467, 30.347875), line: MetroLines.firstRed),
    MetroStationModel(id: 9, title: "Площадь Восстания", latLng: LatLng(59.931483, 30.36036), line: MetroLines.firstRed),
    MetroStationModel(id: 10, title: "Чернышевская", latLng: LatLng(59.944558, 30.359754), line: MetroLines.firstRed),
    MetroStationModel(id: 11, title: "Площадь Ленина", latLng: LatLng(59.955725, 30.355957), line: MetroLines.firstRed),
    MetroStationModel(id: 12, title: "Выборгская", latLng: LatLng(59.97111, 30.347553), line: MetroLines.firstRed),
    MetroStationModel(id: 13, title: "Лесная", latLng: LatLng(59.98477, 30.344201), line: MetroLines.firstRed),
    MetroStationModel(id: 14, title: "Площадь Мужества", latLng: LatLng(59.999655, 30.366595), line: MetroLines.firstRed),
    MetroStationModel(id: 15, title: "Политехническая", latLng: LatLng(60.008926, 30.370952), line: MetroLines.firstRed),
    MetroStationModel(id: 16, title: "Академическая", latLng: LatLng(60.012763, 30.395706), line: MetroLines.firstRed),
    MetroStationModel(id: 17, title: "Гражданский проспект", latLng: LatLng(60.03481, 30.418087), line: MetroLines.firstRed),
    MetroStationModel(id: 18, title: "Девяткино", latLng: LatLng(60.049799, 30.442248), line: MetroLines.firstRed),

    // синяя линия
    MetroStationModel(id: 19, title: "Купчино", latLng: LatLng(59.829887, 30.375399), line: MetroLines.secondBlue),
    MetroStationModel(id: 20, title: "Звёздная", latLng: LatLng(59.833228, 30.349616), line: MetroLines.secondBlue),
    MetroStationModel(id: 21, title: "Московская", latLng: LatLng(59.852192, 30.322206), line: MetroLines.secondBlue),
    MetroStationModel(id: 22, title: "Парк Победы", latLng: LatLng(59.86659, 30.321712), line: MetroLines.secondBlue),
    MetroStationModel(id: 23, title: "Электросила", latLng: LatLng(59.879425, 30.318658), line: MetroLines.secondBlue),
    MetroStationModel(id: 24, title: "Московские Ворота", latLng: LatLng(59.891924, 30.317751), line: MetroLines.secondBlue),
    MetroStationModel(id: 25, title: "Фрунзенская", latLng: LatLng(59.906155, 30.317509), line: MetroLines.secondBlue),
    MetroStationModel(id: 26, title: "Технологический институт-2", latLng: LatLng(59.916622, 30.318505), line: MetroLines.secondBlue),
    MetroStationModel(id: 27, title: "Сенная площадь", latLng: LatLng(59.927090, 30.320378), line: MetroLines.secondBlue),
    MetroStationModel(id: 28, title: "Невский проспект", latLng: LatLng(59.935601, 30.327134), line: MetroLines.secondBlue),
    MetroStationModel(id: 29, title: "Горьковская", latLng: LatLng(59.956323, 30.318724), line: MetroLines.secondBlue),
    MetroStationModel(id: 30, title: "Петроградская", latLng: LatLng(59.966465, 30.311432), line: MetroLines.secondBlue),
    MetroStationModel(id: 31, title: "Чёрная речка", latLng: LatLng(59.985574, 30.300792), line: MetroLines.secondBlue),
    MetroStationModel(id: 32, title: "Пионерская", latLng: LatLng(60.002576, 30.296791), line: MetroLines.secondBlue),
    MetroStationModel(id: 33, title: "Удельная", latLng: LatLng(60.016707, 30.315421), line: MetroLines.secondBlue),
    MetroStationModel(id: 34, title: "Озерки", latLng: LatLng(60.037141, 30.321529), line: MetroLines.secondBlue),
    MetroStationModel(id: 35, title: "Проспект Просвещения", latLng: LatLng(60.051416, 30.332632), line: MetroLines.secondBlue),
    MetroStationModel(id: 36, title: "Парнас", latLng: LatLng(60.06715, 30.334128), line: MetroLines.secondBlue),

    // зеленая линия
    MetroStationModel(id: 37, title: "Приморская", latLng: LatLng(59.948545, 30.234526), line: MetroLines.thirdGreen),
    MetroStationModel(id: 38, title: "Василеостровская", latLng: LatLng(59.942927, 30.278159), line: MetroLines.thirdGreen),
    MetroStationModel(id: 39, title: "Гостиный Двор", latLng: LatLng(59.934049, 30.333772), line: MetroLines.thirdGreen),
    MetroStationModel(id: 40, title: "Маяковская", latLng: LatLng(59.931612, 30.35491), line: MetroLines.thirdGreen),
    MetroStationModel(id: 41, title: "Площадь Александра Невского-1", latLng: LatLng(59.924314, 30.385102), line: MetroLines.thirdGreen),
    MetroStationModel(id: 42, title: "Елизаровская", latLng: LatLng(59.896705, 30.423637), line: MetroLines.thirdGreen),
    MetroStationModel(id: 43, title: "Ломоносовская", latLng: LatLng(59.877433, 30.441951), line: MetroLines.thirdGreen),
    MetroStationModel(id: 44, title: "Пролетарская", latLng: LatLng(59.865275, 30.47026), line: MetroLines.thirdGreen),
    MetroStationModel(id: 45, title: "Обухово", latLng: LatLng(59.848795, 30.457805), line: MetroLines.thirdGreen),
    MetroStationModel(id: 46, title: "Рыбацкое", latLng: LatLng(59.830943, 30.500455), line: MetroLines.thirdGreen),

    // оранжевая линия
    MetroStationModel(id: 47, title: "Улица Дыбенко", latLng: LatLng(59.907573, 30.483292), line: MetroLines.fourthOrange),
    MetroStationModel(id: 48, title: "Проспект Большевиков", latLng: LatLng(59.919819, 30.466908), line: MetroLines.fourthOrange),
    MetroStationModel(id: 49, title: "Ладожская", latLng: LatLng(59.93244, 30.439474), line: MetroLines.fourthOrange),
    MetroStationModel(id: 50, title: "Новочеркасская", latLng: LatLng(59.92933, 30.412918), line: MetroLines.fourthOrange),
    MetroStationModel(id: 51, title: "Площадь Александра Невского-2", latLng: LatLng(59.92365, 30.383471), line: MetroLines.fourthOrange),
    MetroStationModel(id: 52, title: "Лиговский проспект", latLng: LatLng(59.920747, 30.355245), line: MetroLines.fourthOrange),
    MetroStationModel(id: 53, title: "Достоевская", latLng: LatLng(59.928072, 30.345746), line: MetroLines.fourthOrange),
    MetroStationModel(id: 54, title: "Спасская", latLng: LatLng(59.926839, 30.319752), line: MetroLines.fourthOrange),

    // фиолетовая линия
    MetroStationModel(id: 55, title: "Международная", latLng: LatLng(59.869966, 30.379045), line: MetroLines.fifthPurple),
    MetroStationModel(id: 56, title: "Бухарестская", latLng: LatLng(59.883681, 30.369673), line: MetroLines.fifthPurple),
    MetroStationModel(id: 57, title: "Волковская", latLng: LatLng(59.896265, 30.35686), line: MetroLines.fifthPurple),
    MetroStationModel(id: 58, title: "Обводный канал", latLng: LatLng(59.914697, 30.349361), line: MetroLines.fifthPurple),
    MetroStationModel(id: 59, title: "Звенигородская", latLng: LatLng(59.922304, 30.335784), line: MetroLines.fifthPurple),
    MetroStationModel(id: 60, title: "Садовая", latLng: LatLng(59.927008, 30.317456), line: MetroLines.fifthPurple),
    MetroStationModel(id: 61, title: "Адмиралтейская", latLng: LatLng(59.935877, 30.314886), line: MetroLines.fifthPurple),
    MetroStationModel(id: 62, title: "Спортивная-1", latLng: LatLng(59.952078, 30.291312), line: MetroLines.fifthPurple),
    MetroStationModel(id: 63, title: "Спортивная-2", latLng: LatLng(59.950365, 30.287356), line: MetroLines.fifthPurple),
    MetroStationModel(id: 64, title: "Чкаловская", latLng: LatLng(59.961035, 30.291964), line: MetroLines.fifthPurple),
    MetroStationModel(id: 65, title: "Крестовский остров", latLng: LatLng(59.971838, 30.259427), line: MetroLines.fifthPurple),
    MetroStationModel(id: 66, title: "Старая Деревня", latLng: LatLng(59.989228, 30.255169), line: MetroLines.fifthPurple),
    MetroStationModel(id: 67, title: "Комендантский проспект", latLng: LatLng(60.008356, 30.258915), line: MetroLines.fifthPurple),
  ];

  static List<MetroStationModel> getAllMetroStations() {
    return _allMetroStations;
  }

  static List<MetroStationModel> getNearestMetroStations({
    required LatLng latLng,
  }) {
    final List<MetroStationModel> result = [];
    for (final station in _allMetroStations) {
      if (_distanceInKmBetweenEarthCoordinates(latLng.latitude, latLng.longitude, station.latLng.latitude, station.latLng.longitude) < 1) {
        result.add(station);
      }
    }
    return result;
  }
}
