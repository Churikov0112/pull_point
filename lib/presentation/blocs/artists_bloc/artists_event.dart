part of 'artists_bloc.dart';

abstract class ArtistsEvent extends Equatable {
  const ArtistsEvent();

  @override
  List<Object> get props => [];
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
