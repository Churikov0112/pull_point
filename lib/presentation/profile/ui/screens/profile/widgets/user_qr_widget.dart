import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/data/http_requests/backend_config/backend_config.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../../blocs/blocs.dart';
import '../../../../../ui_kit/ui_kit.dart';

class ArtistQRWidget extends StatelessWidget {
  const ArtistQRWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocBuilder<UserArtistsBloc, UserArtistsState>(
      builder: (context, userArtistsState) {
        if (userArtistsState is UserArtistsStateSelected) {
          return TouchableOpacity(
            onPressed: () {},
            child: Container(
              width: mediaQuery.size.width,
              decoration: const BoxDecoration(
                color: AppColors.backgroundCard,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: QrImage(
                    data: "${BackendConfig.baseUrl}/artist/${userArtistsState.selectedArtist.name}",
                    version: QrVersions.auto,
                    size: 200,
                  ),
                ),
              ),
            ),
          );
        }
        if (userArtistsState is UserArtistsStateLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColors.orange));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
