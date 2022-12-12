part of 'user_artists_bloc.dart';

abstract class UserArtistsEvent extends Equatable {
  const UserArtistsEvent();

  @override
  List<Object> get props => [];
}

class UserArtistsEventLoad extends UserArtistsEvent {
  final int userId;

  const UserArtistsEventLoad({
    required this.userId,
  });
}

class UserArtistsEventSelect extends UserArtistsEvent {
  final int artistId;
  final int userId;

  const UserArtistsEventSelect({
    required this.artistId,
    required this.userId,
  });
}

class UserArtistsEventResetSelectOnLogout extends UserArtistsEvent {
  const UserArtistsEventResetSelectOnLogout();
}
