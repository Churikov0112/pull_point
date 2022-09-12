import 'package:flutter/material.dart' show CircularProgressIndicator, Colors, FloatingActionButton, Icons, MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:pull_point/presentation/feed/ui/screens/feed/poster_item.dart';
import 'package:pull_point/presentation/static_methods/static_methods.dart';
import '../../../../../domain/domain.dart';
import '../../../../blocs/blocs.dart';
import '../../../../ui_kit/ui_kit.dart';
import '../screens.dart';

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
                  if (pullPointsState is PullPointsStateLoaded) {
                    List<PullPointModel> loadedPullPoints = pullPointsState.pullPoints;
                    return BlocBuilder<FeedFiltersBloc, FeedFiltersState>(
                      builder: (context, filtersState) {
                        // фильтрация пулл поинтов перед отрисовкой
                        if (filtersState is FeedFiltersFilteredState) {
                          loadedPullPoints = pullPointsState.pullPoints;
                          loadedPullPoints = StaticMethods.filterPullPointsByDate(
                            pullPoints: loadedPullPoints,
                            dateFilter: filtersState.filters['date'] as DateFilter?,
                          );
                          loadedPullPoints = StaticMethods.filterPullPointsByTime(
                            pullPoints: loadedPullPoints,
                            timeFilter: filtersState.filters['time'] as TimeFilter?,
                          );
                          loadedPullPoints = StaticMethods.filterPullPointsByNearestMetro(
                            pullPoints: loadedPullPoints,
                            nearestMetroFilter: filtersState.filters['metro'] as NearestMetroFilter?,
                          );
                          loadedPullPoints = StaticMethods.filterPullPointsByCategoriesAndSubcategories(
                            pullPoints: loadedPullPoints,
                            categoriesFilter: filtersState.filters['categories'] as CategoriesFilter?,
                          );
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
                  if (pullPointsState is PullPointsStateLoading) {
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
