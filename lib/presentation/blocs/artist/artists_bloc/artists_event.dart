part of 'artists_bloc.dart';

abstract class ArtistsEvent {
  const ArtistsEvent();
}

class ArtistsEventLoad extends ArtistsEvent {
  final String? search;
  final int? categoryId;
  final List<int>? subcategoryIds;

  const ArtistsEventLoad({
    this.search,
    this.categoryId,
    this.subcategoryIds,
  });
}
