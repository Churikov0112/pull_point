import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pull_point/presentation/auth/ui/screens/screens.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
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
    final AuthRepositoryInterface authRepository = AuthRepositoryImpl(userBox: userBox);
    final ArtistsRepositoryInterface artistsRepository = ArtistsRepositoryImpl(userBox: userBox);
    final PullPointsRepositoryInterface pullPointsRepository = PullPointsRepositoryImpl();
    // final MapFiltersRepositoryInterface mapFiltersRepository = MapFiltersRepositoryImpl();
    final FeedFiltersRepositoryInterface feedFiltersRepository = FeedFiltersRepositoryImpl();
    final CategoriesRepositoryInterface categoriesRepository = CategoriesRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authRepository: authRepository, artistsRepository: artistsRepository)..add(const AuthEventCheckAccoutLocally())),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<PullPointsBloc>(create: (context) => PullPointsBloc(repository: pullPointsRepository)),
        BlocProvider<CreatePullPointBloc>(create: (context) => CreatePullPointBloc(pullPointsRepository: pullPointsRepository)),
        // BlocProvider<MapFiltersBloc>(create: (context) => MapFiltersBloc(mapFiltersRepository: mapFiltersRepository)),
        BlocProvider<FeedFiltersBloc>(create: (context) => FeedFiltersBloc(feedFiltersRepository: feedFiltersRepository)),
        BlocProvider<CategoriesBloc>(create: (context) => CategoriesBloc(categoriesRepository: categoriesRepository)),
        BlocProvider<SubcategoriesBloc>(create: (context) => SubcategoriesBloc(categoriesRepository: categoriesRepository)),
        BlocProvider<ArtistsBloc>(create: (context) => ArtistsBloc(artistsRepository: artistsRepository)),
        BlocProvider<UserArtistsBloc>(create: (context) => UserArtistsBloc(artistsRepository: artistsRepository)),
        // BlocProvider<PersonSearchBloc>(create: (context) => sl<PersonSearchBloc>()),
      ],
      child: MaterialApp(
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(backgroundColor: AppColors.primary),
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
