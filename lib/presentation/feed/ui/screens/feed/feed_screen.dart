import 'package:flutter/material.dart' show CircularProgressIndicator;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/feed/ui/screens/feed/poster_item.dart';

import '../../../../map/blocs/blocs.dart';

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
          builder: (context, state) {
            if (state is LoadedState) {
              return SizedBox(
                height: mediaQuery.size.height - mediaQuery.padding.top - 80,
                width: mediaQuery.size.width,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 50),
                  itemCount: state.pullPoints.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: mediaQuery.size.width / 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemBuilder: (context, index) {
                    return PosterItem(pullPoint: state.pullPoints[index]);
                  },
                ),
              );
            }
            if (state is LoadingState) {
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
