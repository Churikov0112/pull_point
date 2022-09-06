import 'package:flutter/material.dart' show CircularProgressIndicator, Colors, DateTimeRange, FloatingActionButton, Icons, MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:pull_point/presentation/feed/ui/screens/feed/poster_item.dart';
import '../../../../../domain/domain.dart';
import '../../../../map/blocs/blocs.dart';
import '../../../../ui_kit/ui_kit.dart';
import '../../../blocs/blocs.dart';
import '../screens.dart';

List<PullPointModel> filterPullPointsByDate({
  required List<PullPointModel> pullPoints,
  required DateTimeRange dateRange,
}) {
  final List<PullPointModel> filteredPullPoints = [];
  for (final pp in pullPoints) {
    if (pp.startsAt.isAfter(dateRange.start) && pp.endsAt.isBefore(dateRange.end)) {
      filteredPullPoints.add(pp);
    }
  }
  return filteredPullPoints;
}

List<PullPointModel> filterPullPointsByTime({
  required List<PullPointModel> pullPoints,
  required TimeRange timeRange,
}) {
  final List<PullPointModel> filteredPullPoints = [];
  for (final pp in pullPoints) {
    if (pp.startsAt.hour >= timeRange.start.hour) {
      if (pp.startsAt.minute >= timeRange.start.minute) {
        if (pp.endsAt.hour <= timeRange.end.hour) {
          if (pp.startsAt.minute <= timeRange.end.minute) {
            filteredPullPoints.add(pp);
          }
        }
      }
    }
  }
  return filteredPullPoints;
}

List<PullPointModel> filterPullPointsByNearestMetro({
  required List<PullPointModel> pullPoints,
  required List<MetroStationModel> selectedMetroStations,
}) {
  final List<PullPointModel> filteredPullPoints = [];
  for (final pp in pullPoints) {
    for (final metro in selectedMetroStations) {
      if (pp.nearestMetroStations.contains(metro) && !filteredPullPoints.contains(pp)) {
        filteredPullPoints.add(pp);
      }
    }
  }
  return filteredPullPoints;
}

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Position? _currentPosition;
  bool loadingLocation = false;

  void _getLocation() async {
    setState(() => loadingLocation = true);

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      setState(() => loadingLocation = false);
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => loadingLocation = false);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => loadingLocation = false);
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() => loadingLocation = false);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(color: AppColors.backgroundPage),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: mediaQuery.padding.top),
              BlocBuilder<PullPointsBloc, PullPointsState>(
                builder: (context, pullPointsState) {
                  if (pullPointsState is LoadedState) {
                    List<PullPointModel> loadedPullPoints = pullPointsState.pullPoints;
                    return BlocBuilder<FeedFiltersBloc, FeedFiltersState>(
                      builder: (context, filtersState) {
                        // фильтрация пулл поинтов перед отрисовкой
                        if (filtersState is FeedFiltersFilteredState) {
                          loadedPullPoints = pullPointsState.pullPoints;
                          if ((filtersState.filters['date'] as DateFilter?) != null) {
                            loadedPullPoints = filterPullPointsByDate(
                              pullPoints: loadedPullPoints,
                              dateRange: (filtersState.filters['date'] as DateFilter).dateRange,
                            );
                          }
                          if ((filtersState.filters['time'] as TimeFilter?) != null) {
                            loadedPullPoints = filterPullPointsByTime(
                              pullPoints: loadedPullPoints,
                              timeRange: (filtersState.filters['time'] as TimeFilter).timeRange,
                            );
                          }
                          if ((filtersState.filters['metro'] as NearestMetroFilter?) != null) {
                            loadedPullPoints = filterPullPointsByNearestMetro(
                              pullPoints: loadedPullPoints,
                              selectedMetroStations: (filtersState.filters['metro'] as NearestMetroFilter).selectedMetroStations,
                            );
                          }
                        }
                        return Stack(
                          children: [
                            SizedBox(
                              height: mediaQuery.size.height - mediaQuery.padding.top - 56,
                              width: mediaQuery.size.width,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(top: 16),
                                itemCount: loadedPullPoints.length,
                                itemBuilder: (context, index) {
                                  return PosterItemV2(
                                    pullPoint: loadedPullPoints[index],
                                    userLocation: _currentPosition != null ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude) : null,
                                  );
                                },
                              ),
                            ),

                            // filters button
                            Positioned(
                              right: 16,
                              bottom: 20,
                              child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) => const FeedFiltersScreen()));
                                },
                                child: const Center(child: Icon(Icons.filter_alt_outlined, color: Colors.grey)),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  if (pullPointsState is LoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),

        // find location button
        Positioned(
          right: 16,
          bottom: 100,
          child: FloatingActionButton(
            heroTag: null,
            backgroundColor: Colors.white,
            onPressed: () {
              if (_currentPosition == null) {
                _getLocation();
              } else {
                setState(() => _currentPosition = null);
              }
            },
            child: Center(
              child: loadingLocation
                  ? const CircularProgressIndicator(color: AppColors.primary)
                  : _currentPosition != null
                      ? const Icon(Icons.place, color: AppColors.primary)
                      : const Icon(Icons.place_outlined, color: AppColors.icons),
            ),
          ),
        ),
      ],
    );
  }
}
