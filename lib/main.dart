import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init repositories
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // MultiBlocProvider(
        //   providers: const [
        //     // BlocProvider<PersonListCubit>(create: (context) => sl<PersonListCubit>()..loadPerson()),
        //     // BlocProvider<PersonSearchBloc>(create: (context) => sl<PersonSearchBloc>()),
        //   ],
        //   child:
        const MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark().copyWith(
      //   backgroundColor: AppColors.mainBackground,
      //   scaffoldBackgroundColor: AppColors.mainBackground,
      // ),
      home: HomePage(),
      // ),
    );
  }
}
