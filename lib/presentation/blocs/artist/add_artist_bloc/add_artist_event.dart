part of 'add_artist_bloc.dart';

abstract class AddArtistEvent {
  const AddArtistEvent();
}

class AddArtistEventCreate extends AddArtistEvent {
  final UserModel userInput;
  final String name;
  final String description;
  final int categoryId;
  final List<int>? subcategoryIds;

  const AddArtistEventCreate({
    required this.userInput,
    required this.name,
    required this.description,
    required this.categoryId,
    this.subcategoryIds,
  });
}
