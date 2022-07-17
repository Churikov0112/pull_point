import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/home/home_page.dart';
import 'data/data.dart';
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
        BlocProvider<PullPointsBloc>(create: (context) => PullPointsBloc(repository: PullPointsRepositoryImpl())),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        // BlocProvider<PersonSearchBloc>(create: (context) => sl<PersonSearchBloc>()),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark().copyWith(
        //   backgroundColor: AppColors.mainBackground,
        //   scaffoldBackgroundColor: AppColors.mainBackground,
        // ),
        home: const HomePage(),
      ),
    );
  }
}
