// import 'dart:convert';
// import 'package:http/http.dart' as http;

import '../../../domain/domain.dart';

class PullPointsRepositoryImpl extends PullPointsRepositoryInterface {
  List<PullPointModel> allPullPoints = [];
  List<CategoryModel> highLevelCategories = [];

  @override
  Future<List<PullPointModel>> getPullPoints() async {
    try {
      if (allPullPoints.isEmpty) {
        // final response = await http.get(Uri.parse("http://pullpoint.ru:2022/guest/getPullPoints"));
        // String source = const Utf8Decoder().convert(response.bodyBytes);
        // print(source);

        final json = [
          {
            "id": 1,
            "name": "Стрит на Грибе",
            "start": 1659807806,
            "end": 1659721406,
            "geo": {
              "latitude": 59.935601,
              "longitude": 30.327134,
              "address": null,
            },
            "description": "Традиционный стрит на Канале Грибоедова",
            "artists": [
              {
                "id": 1,
                "name": "Дешёвые драмы",
                "description": "Лучший уличный коллектив города Санкт-Петербурга.",
                "avatar": "https://musclub.ru/data/catalog/f/e/4/fe4fdd9fed9b911c3ee6512e4493051e.jpeg",
                "categories": [
                  {"id": 1, "name": "Музыка", "pic": "somepic"}
                ]
              }
            ]
          },
          {
            "id": 2,
            "name": "Худшее фаер-шоу на свете",
            "start": 1659635006,
            "end": 1660153406,
            "geo": {
              "latitude": 59.936521,
              "longitude": 30.500014,
              "address": "Белорусская, 6",
            },
            "description": "Абсолютно точно не проплаченная реклама артиста dec-a-dance (подписывайтесь на паблик)",
            "artists": [
              {
                "id": 2,
                "name": "dec-a-dance",
                "avatar": "https://i.pinimg.com/736x/0a/82/cd/0a82cd53712e023c19c53a7941bffb98--dancer-silhouette-dance-dance-dance.jpg",
                "description": "Какой-то странный чел снова устраивает фаер-шоу",
                "categories": [
                  {"id": 2, "name": "Фаер-шоу", "pic": "somepic"}
                ]
              }
            ]
          },
          {
            "id": 3,
            "name": "Рисуем грибы",
            "start": 1659635006,
            "end": 1661881406,
            "geo": {
              "latitude": 60.049799,
              "longitude": 30.442248,
              "address": "около метро Девяткино",
            },
            "description": "Мастер-класс по рисованию грибов любой сложности",
            "artists": [
              {
                "id": 3,
                "avatar": "https://podarokmos.ru/wp-content/uploads/8/5/b/85b789b50f99936b3f06244d5b6f9e3a.jpeg",
                "name": "Рисуем грибы за 10 минут",
                "description": "Учимся рисовать грибы всего за 10 минут у профессиональных художников.",
                "categories": [
                  {"id": 3, "name": "Художники", "pic": "somepic"}
                ]
              }
            ]
          },
        ];

        allPullPoints.clear();

        for (final element in json) {
          allPullPoints.add(PullPointModel.fromJson(element));
        }

        //   allPullPoints = [
        //     PullPointModel(
        //       id: 0,
        //       title: 'Стрит',
        //       description: "Магия музыки и ритма в центре Санкт-Петербурга. Уникальные инструменты",
        //       address: 'ст.м. Невский проспект',
        //       startsAt: DateTime(2022, 7, 25, 15, 0),
        //       endsAt: DateTime(2022, 7, 25, 18, 0),
        //       latLng: LatLng(59.9386, 30.3141),
        //       artist: const ArtistModel(
        //         id: 0,
        //         name: 'Космо Кот',
        //         description: "Космо Кот — легенда Петербурга. Сейчас композитора можно часто встретить на площадках проекта «Музыка в метро».",
        //       ),
        //       posterUrl: "https://cs4.pikabu.ru/post_img/big/2014/06/01/10/1401638213_127727120.jpg",
        //     ),
        //     PullPointModel(
        //       id: 1,
        //       title: 'Вечерний джаз',
        //       description:
        //           "Приятный теплый вечер под приятную музыку! Приходите сами, приводите друзей, тут рады всемПриятный теплый вечер под приятную музыку! Приходите сами, приводите друзей, тут рады всемПриятный теплый вечер под приятную музыку! Приходите сами, приводите друзей, тут рады всем",
        //       address: 'ст.м. Адмиралтейская',
        //       startsAt: DateTime(2022, 7, 26, 12, 0),
        //       endsAt: DateTime(2022, 7, 26, 15, 0),
        //       latLng: LatLng(59.9, 30.3),
        //       artist: const ArtistModel(
        //         id: 1,
        //         name: 'Банд-М',
        //         description:
        //             "Российская поп-группа, основанная композитором и продюсером Константином Меладзе. Группа была создана 22 ноября 2014 года после финала шоу «Хочу к Меладзе».",
        //       ),
        //       posterUrl: "https://avatars.mds.yandex.net/get-zen_doc/964926/pub_5b85312fc1ccb200a9cfb1b8_5b85316bd6e1a500a9c28863/scale_1200",
        //     ),
        //     PullPointModel(
        //       id: 2,
        //       title: 'Пою русские народные песни',
        //       address: 'Смольная набережная',
        //       description: "Описание выстпления - обязательное поле, чтобы было что отображать и окно не казалось таким уж пустым",
        //       startsAt: DateTime(2022, 7, 28, 19, 30),
        //       endsAt: DateTime(2022, 7, 28, 23, 0),
        //       latLng: LatLng(59.95, 30.4),
        //       artist: const ArtistModel(id: 2, name: 'Музыкалити', description: "Описание артиста надо сделать обязательным!"),
        //     ),
        //     PullPointModel(
        //       id: 3,
        //       title: 'fire-шоу',
        //       address: 'Белорусская 6',
        //       description: "Поджигаю облитую бензином японскую катану и показываю красивый акробатичнские трюки",
        //       startsAt: DateTime(2022, 7, 30, 23, 0),
        //       endsAt: DateTime(2022, 7, 31, 2, 15),
        //       latLng: LatLng(59.936521, 30.500014),
        //       artist: const ArtistModel(id: 2, name: 'Самурай', description: "Описание артиста надо сделать обязательным!"),
        //     ),
        //   ];

      }
    } catch (e) {
      print(e);
    }
    return allPullPoints;
  }
}
