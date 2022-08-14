import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../domain/domain.dart';
import '../../config/config.dart';

class PullPointsRepositoryImpl extends PullPointsRepositoryInterface {
  List<PullPointModel> allPullPoints = [];
  List<CategoryModel> highLevelCategories = [];

  @override
  Future<List<PullPointModel>> getPullPoints() async {
    try {
      if (allPullPoints.isEmpty) {
        final response = await http.get(Uri.parse("${BackendConfig.baseUrl}/guest/getPullPoints"));
        String source = const Utf8Decoder().convert(response.bodyBytes);
        print(source);

        final decodedResponse = jsonDecode(source);
        for (final element in decodedResponse) {
          allPullPoints.add(PullPointModel.fromJson(element));
        }

        // final json = [
        //   {
        //     "id": 1,
        //     "name": "Стрит на Грибе",
        //     "start": 1659807806,
        //     "end": 1659721406,
        //     "geo": {
        //       "latitude": 59.935601,
        //       "longitude": 30.327134,
        //       "address": null,
        //     },
        //     "description": "Традиционный стрит на Канале Грибоедова",
        //     "artists": [
        //       {
        //         "id": 1,
        //         "name": "Дешёвые драмы",
        //         "description": "Лучший уличный коллектив города Санкт-Петербурга.",
        //         "avatar": "https://musclub.ru/data/catalog/f/e/4/fe4fdd9fed9b911c3ee6512e4493051e.jpeg",
        //         "categories": [
        //           {"id": 1, "name": "Музыка", "pic": "somepic"}
        //         ]
        //       }
        //     ]
        //   },
        //   {
        //     "id": 2,
        //     "name": "Худшее фаер-шоу на свете",
        //     "start": 1659635006,
        //     "end": 1660153406,
        //     "geo": {
        //       "latitude": 59.936521,
        //       "longitude": 30.500014,
        //       "address": "Белорусская, 6",
        //     },
        //     "description": "Абсолютно точно не проплаченная реклама артиста dec-a-dance (подписывайтесь на паблик)",
        //     "artists": [
        //       {
        //         "id": 2,
        //         "name": "dec-a-dance",
        //         "avatar": "https://i.pinimg.com/736x/0a/82/cd/0a82cd53712e023c19c53a7941bffb98--dancer-silhouette-dance-dance-dance.jpg",
        //         "description": "Какой-то странный чел снова устраивает фаер-шоу",
        //         "categories": [
        //           {"id": 2, "name": "Фаер-шоу", "pic": "somepic"}
        //         ]
        //       }
        //     ]
        //   },
        //   {
        //     "id": 3,
        //     "name": "Рисуем грибы",
        //     "start": 1659635006,
        //     "end": 1661881406,
        //     "geo": {
        //       "latitude": 60.049799,
        //       "longitude": 30.442248,
        //       "address": "около метро Девяткино",
        //     },
        //     "description": "Мастер-класс по рисованию грибов любой сложности",
        //     "artists": [
        //       {
        //         "id": 3,
        //         "avatar": "https://podarokmos.ru/wp-content/uploads/8/5/b/85b789b50f99936b3f06244d5b6f9e3a.jpeg",
        //         "name": "Рисуем грибы за 10 минут",
        //         "description": "Учимся рисовать грибы всего за 10 минут у профессиональных художников.",
        //         "categories": [
        //           {"id": 3, "name": "Художники", "pic": "somepic"}
        //         ]
        //       }
        //     ]
        //   },
        // ];

        allPullPoints.clear();

        // for (final element in source) {
        //   allPullPoints.add(PullPointModel.fromJson(element));
        // }
      }
    } catch (e) {
      print(e);
    }
    return allPullPoints;
  }
}
