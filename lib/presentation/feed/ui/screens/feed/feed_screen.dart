import 'package:flutter/material.dart'
    show CircularProgressIndicator, Colors, FloatingActionButton, Icons, MaterialPageRoute, RefreshIndicator;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  LatLng? _currentUserLocation;
  bool loadingLocation = false;

  Future<LatLng?> getLocation() async {
    setState(() => loadingLocation = true);
    LatLng? userLocation;
    userLocation = await StaticMethods.getUserLocation();
    if (userLocation != null) {
      setState(() => _currentUserLocation = userLocation);
    } else {
      setState(() => loadingLocation = false);
    }
    setState(() => loadingLocation = false);
    return userLocation;
  }

  void refreshPullPoints() {
    context.read<PullPointsBloc>().add(const PullPointsEventLoad());
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
                        loadedPullPoints = StaticMethods.filterPullPointsByNotExpire(
                          pullPoints: loadedPullPoints,
                        );

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
                          loadedPullPoints = StaticMethods.filterPullPointsByNotExpire(
                            pullPoints: loadedPullPoints,
                          );
                        }
                        return Stack(
                          children: [
                            SizedBox(
                              height: mediaQuery.size.height - mediaQuery.padding.top - 56,
                              width: mediaQuery.size.width,
                              child: RefreshIndicator(
                                displacement: 100,
                                color: AppColors.orange,
                                onRefresh: () async {
                                  await Future.delayed(const Duration(milliseconds: 500));
                                  refreshPullPoints();
                                },
                                child: ListView.builder(
                                  padding: const EdgeInsets.only(top: 16),
                                  itemCount: loadedPullPoints.length,
                                  itemBuilder: (context, index) {
                                    return PosterItemV2(
                                      pullPoint: loadedPullPoints[index],
                                      userLocation: _currentUserLocation != null
                                          ? LatLng(_currentUserLocation!.latitude, _currentUserLocation!.longitude)
                                          : null,
                                    );
                                  },
                                ),
                              ),
                            ),

                            // filters button
                            Positioned(
                              right: 16,
                              bottom: 20,
                              child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute<void>(
                                      builder: (BuildContext context) => const FeedFiltersScreen()));
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
                    return const Center(child: CircularProgressIndicator(color: AppColors.orange));
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
            onPressed: () async {
              if (_currentUserLocation == null) {
                await getLocation();
              } else {
                setState(() => _currentUserLocation = null);
              }
            },
            child: Center(
              child: loadingLocation
                  ? const CircularProgressIndicator(color: AppColors.primary)
                  : _currentUserLocation != null
                      ? const Icon(Icons.place, color: AppColors.primary)
                      : const Icon(Icons.place_outlined, color: AppColors.icons),
            ),
          ),
        ),
      ],
    );
  }
}
