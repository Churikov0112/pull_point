import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/models.dart';
import '../../../../ui_kit/ui_kit.dart';
import 'widgets/widgets.dart';

class ArtistsScreen extends StatefulWidget {
  const ArtistsScreen({super.key});

  @override
  State<ArtistsScreen> createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  late CarouselController carouselController;
  int currentArtistIndex = 0;

  @override
  void initState() {
    carouselController = CarouselController();

    // setInitialIndexBySelectedArtist(allUserArtists: , selectedArtistId: ,);
    super.initState();
  }

  void setInitialIndexBySelectedArtist({
    required int selectedArtistId,
    required List<ArtistModel> allUserArtists,
  }) {
    for (var i = 0; i < allUserArtists.length; i++) {
      if (selectedArtistId == allUserArtists[i].id) {
        currentArtistIndex = i;
      }
    }
  }

  List<Widget> buildArtistCards({required List<ArtistModel> artists}) {
    return artists.map((artist) => ArtistCard(artist: artist)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // TODO artists bloc builder here

    final artists = [
      const ArtistModel(
        id: 555,
        name: 'dummy artist loooooooooooooong name',
        description: 'dummy artist loooooooooooooooooooooooooooooooong description',
      ),
      const ArtistModel(
        id: 556,
        name: 'деревенский дурачок',
        description: 'описание описаниеописание описаниеописаниеописание описаниеописаниеописание',
      ),
      const ArtistModel(
        id: 557,
        name: 'Свидетель из Фрязино',
        description: '...',
      ),
      const ArtistModel(
        id: 558,
        name: 'плыли мы по морю',
        description: 'вечер мачту рвал, капитан - залупа, с корабля сбежал',
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: mediaQuery.padding.top + 30),
          CarouselSlider(
            items: buildArtistCards(artists: artists),
            carouselController: carouselController,
            options: CarouselOptions(
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() => currentArtistIndex = index);
                }),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: artists.asMap().entries.map(
              (entry) {
                return GestureDetector(
                  onTap: () => carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                          .withOpacity(currentArtistIndex == entry.key ? 0.9 : 0.4),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
