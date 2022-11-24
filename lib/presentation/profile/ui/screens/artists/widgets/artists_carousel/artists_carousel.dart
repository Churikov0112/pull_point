import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

class ArtistsCarousel extends StatelessWidget {
  const ArtistsCarousel({
    required this.items,
    required this.currentIndex,
    required this.carouselController,
    required this.onPageChanged,
    super.key,
  });

  final List<Widget>? items;
  final int currentIndex;
  final CarouselController carouselController;
  final Function(int, CarouselPageChangedReason)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: items,
      carouselController: carouselController,
      options: CarouselOptions(
        initialPage: currentIndex,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        aspectRatio: 2.0,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
