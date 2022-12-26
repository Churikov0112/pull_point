import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:pull_point/presentation/auth/ui/screens/screens.dart';
import 'package:pull_point/presentation/home/home_page.dart';

import 'data/data.dart';
import 'domain/domain.dart';
import 'presentation/blocs/blocs.dart';
import 'presentation/ui_kit/ui_kit.dart';

late Box<UserModel?> userBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.registerAdapter(UserModelAdapter());
  Hive.init(directory.path);
  userBox = await Hive.openBox<UserModel?>('user_data');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // чтобы в нескольких местах использовать один объект
    final AuthRepositoryInterface authRepository = AuthRepositoryImpl();
    final ArtistsRepositoryInterface artistsRepository = ArtistsRepositoryImpl();
    final PullPointsRepositoryInterface pullPointsRepository = PullPointsRepositoryImpl();
    final WalletRepositoryInterface walletRepository = WalletRepositoryImpl();
    final FeedFiltersRepositoryInterface feedFiltersRepository = FeedFiltersRepositoryImpl();
    final CategoriesRepositoryInterface categoriesRepository = CategoriesRepositoryImpl();
    final FavoritesRepositoryInterface favoritesRepository = FavoritesRepositoryImpl();

    // final MapFiltersRepositoryInterface mapFiltersRepository = MapFiltersRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        // auth blocs
        BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: authRepository, artistsRepository: artistsRepository)
              ..add(const AuthEventCheckAccoutLocally())),
        BlocProvider<CheckUsernameExistenceBloc>(
            create: (context) => CheckUsernameExistenceBloc(authRepository: authRepository)),

        // home screen (tabbar) bloc
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),

        // pull point blocs
        BlocProvider<PullPointsBloc>(
          create: (context) => PullPointsBloc(
            repository: pullPointsRepository,
          ),
        ),

        BlocProvider<CreatePullPointBloc>(
            create: (context) => CreatePullPointBloc(pullPointsRepository: pullPointsRepository)),

        // filter blocs
        BlocProvider<FeedFiltersBloc>(
            create: (context) => FeedFiltersBloc(feedFiltersRepository: feedFiltersRepository)),

        // category blocs
        BlocProvider<CategoriesBloc>(create: (context) => CategoriesBloc(categoriesRepository: categoriesRepository)),
        BlocProvider<SubcategoriesBloc>(
            create: (context) => SubcategoriesBloc(categoriesRepository: categoriesRepository)),

        // artist blocs
        BlocProvider<ArtistsBloc>(create: (context) => ArtistsBloc(artistsRepository: artistsRepository)),
        BlocProvider<AddArtistBloc>(create: (context) => AddArtistBloc(artistsRepository: artistsRepository)),
        BlocProvider<DeleteArtistBloc>(create: (context) => DeleteArtistBloc(artistsRepository: artistsRepository)),
        BlocProvider<UserArtistsBloc>(create: (context) => UserArtistsBloc(artistsRepository: artistsRepository)),
        BlocProvider<CheckArtistNameExistenceBloc>(
            create: (context) => CheckArtistNameExistenceBloc(artistsRepository: artistsRepository)),

        // wallet blocs
        BlocProvider<CreateWalletBloc>(create: (context) => CreateWalletBloc(walletRepository: walletRepository)),
        BlocProvider<WalletBloc>(create: (context) => WalletBloc(walletRepository: walletRepository)),
        BlocProvider<WalletHistoryBloc>(create: (context) => WalletHistoryBloc(walletRepository: walletRepository)),
        BlocProvider<WalletAddingMoneyBloc>(
            create: (context) => WalletAddingMoneyBloc(walletRepository: walletRepository)),
        BlocProvider<WalletWithdrawMoneyBloc>(
            create: (context) => WalletWithdrawMoneyBloc(walletRepository: walletRepository)),
        BlocProvider<WalletTransferMoneyBloc>(
            create: (context) => WalletTransferMoneyBloc(walletRepository: walletRepository)),

        // favorites blocs
        BlocProvider<GetFavoritesBloc>(create: (context) => GetFavoritesBloc(favoritesRepository: favoritesRepository)),
        BlocProvider<AddFavoritesBloc>(create: (context) => AddFavoritesBloc(favoritesRepository: favoritesRepository)),
        BlocProvider<DeleteFavoritesBloc>(
            create: (context) => DeleteFavoritesBloc(favoritesRepository: favoritesRepository)),
      ],
      child: MaterialApp(
        title: "Pull Point",
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          backgroundColor: AppColors.primary,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthStateAuthorized) return const HomePage();

            return const StartScreen();
          },
        ),
        // home: const HomePage(),
      ),
    );
  }
}
