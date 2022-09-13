part of 'add_artist_bloc.dart';

abstract class AddArtistEvent extends Equatable {
  const AddArtistEvent();

  @override
  List<Object> get props => [];
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

  @override
  List<Object> get props => [name, description, categoryId, userInput.id];
}
