import 'package:flutter/material.dart' show CircularProgressIndicator, Colors, DateTimeRange, FloatingActionButton, Icons, MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/feed/ui/screens/feed/poster_item.dart';
import '../../../../../domain/domain.dart';
import '../../../../map/blocs/blocs.dart';
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

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: mediaQuery.padding.top),
        BlocBuilder<PullPointsBloc, PullPointsState>(
          builder: (context, pullPointsState) {
            if (pullPointsState is LoadedState) {
              List<PullPointModel> loadedPullPoints = pullPointsState.pullPoints;
              return BlocBuilder<FeedFiltersBloc, FeedFiltersState>(
                builder: (context, filtersState) {
                  if (filtersState is FeedFiltersFilteredState) {
                    loadedPullPoints = pullPointsState.pullPoints;
                    if (filtersState.dateTimeFilter.dateRange != null) {
                      loadedPullPoints = filterPullPointsByDate(pullPoints: loadedPullPoints, dateRange: filtersState.dateTimeFilter.dateRange!);
                    }
                    if (filtersState.dateTimeFilter.timeRange != null) {
                      loadedPullPoints = filterPullPointsByTime(pullPoints: loadedPullPoints, timeRange: filtersState.dateTimeFilter.timeRange!);
                    }
                  }
                  return Stack(
                    children: [
                      SizedBox(
                        height: mediaQuery.size.height - mediaQuery.padding.top - 80,
                        width: mediaQuery.size.width,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 50),
                          itemCount: loadedPullPoints.length,
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: mediaQuery.size.width / 2,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                          ),
                          itemBuilder: (context, index) {
                            return PosterItem(pullPoint: loadedPullPoints[index]);
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
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => const FeedFiltersScreen(),
                              ),
                            );
                          },
                          child: const Center(
                            child: Icon(Icons.filter_alt_outlined, color: Colors.grey),
                          ),
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
    );
  }
}
