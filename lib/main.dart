import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pull_point/presentation/auth/ui/screens/enter_code_screen/enter_code_screen.dart';
import 'package:pull_point/presentation/auth/ui/screens/enter_user_data_screen/enter_user_data_screen.dart';
import 'package:pull_point/presentation/auth/ui/screens/screens.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:pull_point/presentation/home/home_page.dart';
import 'data/data.dart';
import 'domain/domain.dart';
import 'presentation/auth/blocs/blocs.dart';
import 'presentation/feed/blocs/blocs.dart';
import 'presentation/home/blocs/blocs.dart';
import 'presentation/map/blocs/blocs.dart';
import 'presentation/ui_kit/ui_kit.dart';

void main() async {
  // final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDir.path);
  // Hive.registerAdapter(UserModelAdapter()); // регистрируем адаптер user
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepositoryImpl: AuthRepositoryImpl())),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<PullPointsBloc>(create: (context) => PullPointsBloc(repository: PullPointsRepositoryImpl())),
        BlocProvider<MapFiltersBloc>(create: (context) => MapFiltersBloc(mapFiltersRepository: MapFiltersRepositoryImpl())),
        BlocProvider<FeedFiltersBloc>(create: (context) => FeedFiltersBloc(feedFiltersRepository: FeedFiltersRepositoryImpl())),
        // BlocProvider<PersonSearchBloc>(create: (context) => sl<PersonSearchBloc>()),
      ],
      child: MaterialApp(
        builder: BotToastInit(),
        // builder: (context, child) {
        //   return ScrollConfiguration(
        //     behavior: CustomScrollBehavior(),
        //     child: child!,
        //   );
        // },
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          backgroundColor: AppColors.primary,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthStateUnauthorized) return const StartScreen();
            if (state is AuthStateCodeSent) return Center(child: EnterCodeScreen(email: state.email));
            if (state is AuthStateCodeVerified) return Center(child: EnterUserDataScreen(userId: state.id, email: state.email));
            if (state is AuthStateAuthorized || state is AuthStateGuest) return const HomePage();
            return const Center(child: CircularProgressIndicator());
          },
        ),
        // home: const HomePage(),
      ),
    );
  }
}
