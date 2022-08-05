import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/auth/ui/screens/screens.dart';
import 'package:pull_point/presentation/home/home_page.dart';
import 'data/data.dart';
import 'presentation/feed/blocs/blocs.dart';
import 'presentation/home/blocs/blocs.dart';
import 'presentation/map/blocs/blocs.dart';
import 'presentation/ui_kit/ui_kit.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
        home: const StartScreen(),
        // home: const HomePage(),
      ),
    );
  }
}
