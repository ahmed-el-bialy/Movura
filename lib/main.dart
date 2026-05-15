import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movura/core/routing/app_router.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp( Movura(appRouter: AppRouter(),));
}

class Movura extends StatelessWidget {
  const Movura({super.key, required this.appRouter});
final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute:appRouter.generateRoute ,
    );
  }
}
