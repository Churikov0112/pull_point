import 'package:latlong2/latlong.dart';
import '../../../domain/domain.dart';

class PullPointsRepositoryImpl extends PullPointsRepositoryInterface {
  List<PullPointModel> allPullPoints = [];
  List<CategoryModel> highLevelCategories = [];

  @override
  Future<List<PullPointModel>> getPullPoints({
    DateTimeFilter? dateTimeFilter,
  }) async {
    // TODO (churikov_egor): remove mock

    if (allPullPoints.isEmpty) {
      await Future.delayed(const Duration(seconds: 3));
      print("PullPoints loaded from network with fake duration");
      allPullPoints = [
        PullPointModel(
          id: 0,
          title: 'Стрит',
          description: "Магия музыки и ритма в центре Санкт-Петербурга. Уникальные инструменты",
          address: 'ст.м. Невский проспект',
          createdAt: DateTime.now(),
          startsAt: DateTime.now(),
          endsAt: DateTime.now().add(const Duration(hours: 2)),
          latLng: LatLng(59.9386, 30.3141),
          category: const CategoryModel(
            id: 1,
            name: "Музыка",
            children: [
              CategoryModel(id: 10, name: "Кавер"),
              CategoryModel(id: 11, name: "Авторская песня"),
              CategoryModel(id: 12, name: "Рок"),
              CategoryModel(id: 13, name: "Рэп"),
            ],
          ),
          artist: const ArtistModel(
            id: 0,
            name: 'Космо Кот',
            description:
                "Космо Кот — легенда Петербурга. Сейчас композитора можно часто встретить на площадках проекта «Музыка в метро».",
          ),
          posterUrl: "https://cs4.pikabu.ru/post_img/big/2014/06/01/10/1401638213_127727120.jpg",
        ),
        PullPointModel(
          id: 1,
          title: 'Вечерний джаз',
          description: "Приятный теплый вечер под приятную музыку! Приходите сами, приводите друзей, тут рады всем",
          address: 'ст.м. Адмиралтейская',
          createdAt: DateTime.now(),
          startsAt: DateTime.now(),
          endsAt: DateTime.now().add(const Duration(hours: 2)),
          latLng: LatLng(59.9, 30.3),
          category: const CategoryModel(
            id: 0,
            name: "Музыка",
            children: [
              CategoryModel(id: 4, name: "Джаз"),
              CategoryModel(id: 5, name: "Блюз"),
            ],
          ),
          artist: const ArtistModel(
            id: 1,
            name: 'Банд-М',
            description:
                "Российская поп-группа, основанная композитором и продюсером Константином Меладзе. Группа была создана 22 ноября 2014 года после финала шоу «Хочу к Меладзе».",
          ),
          posterUrl:
              "https://avatars.mds.yandex.net/get-zen_doc/964926/pub_5b85312fc1ccb200a9cfb1b8_5b85316bd6e1a500a9c28863/scale_1200",
        ),
        PullPointModel(
          id: 2,
          title: 'Пою русские народные песни',
          address: 'Смольная набережная',
          description:
              "Описание выстпления - обязательное поле, чтобы было что отображать и окно не казалось таким уж пустым",
          createdAt: DateTime.now(),
          startsAt: DateTime.now(),
          endsAt: DateTime.now().add(const Duration(hours: 2)),
          latLng: LatLng(59.95, 30.4),
          category: const CategoryModel(
            id: 0,
            name: "Музыка",
            children: [
              CategoryModel(id: 3, name: "Рэп"),
            ],
          ),
          artist:
              const ArtistModel(id: 2, name: 'Музыкалити', description: "Описание артиста надо сделать обязательным!"),
        ),
        PullPointModel(
          id: 3,
          title: 'fire-шоу',
          address: 'Белорусская 6',
          description: "Поджигаю облитую бензином японскую катану и показываю красивый акробатичнские трюки",
          createdAt: DateTime.now(),
          startsAt: DateTime.now(),
          endsAt: DateTime.now().add(const Duration(hours: 2)),
          latLng: LatLng(59.936521, 30.500014),
          category: const CategoryModel(
            id: 1,
            name: "Фаер-шоу",
            children: [
              CategoryModel(id: 6, name: "Танцы"),
              CategoryModel(id: 7, name: "Акробатика"),
            ],
          ),
          artist: const ArtistModel(id: 2, name: 'Самурай', description: "Описание артиста надо сделать обязательным!"),
        ),
      ];
    }

    if (dateTimeFilter != null) {
      final List<PullPointModel> result = [];
      for (final pp in allPullPoints) {
        if (pp.startsAt.isAfter(dateTimeFilter.from) && pp.startsAt.isBefore(dateTimeFilter.until)) {
          result.add(pp);
        }
      }
      return result;
    }

    return allPullPoints;
  }
}
