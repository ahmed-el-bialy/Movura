import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/routing/app_router.dart';
import 'package:movura/core/theming/app_theme.dart';
import 'package:movura/features/home/logic/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movura/features/home/logic/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'package:movura/features/home/logic/trending_content/trending_content_cubit.dart';
import 'package:movura/firebase_options.dart';

import 'core/networking/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: ".env");
  await initDI();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TrendingContentCubit>()..getTrendingPosters(),
        ),
        BlocProvider(
          create: (context) => sl<TopRatedMovieCubit>()..getTopRatedMovies(),
        ),
        BlocProvider(
          create: (context) => sl<TopRatedTvSeriesCubit>()..getTopRatedTvSeries(),
        ),
      ],
      child: Movura(appRouter: AppRouter()),
    ),
  );
}

class Movura extends StatelessWidget {
  const Movura({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (_, child) {
        return MaterialApp(
          onGenerateRoute: appRouter.generateRoute,
          theme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}