import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/coffee_menu/data/providers/coffee_api_provider.dart';
import 'features/coffee_menu/data/repositories/coffee_repository.dart';
import 'features/coffee_menu/logic/coffee_bloc/coffee_bloc.dart';
import 'features/coffee_menu/logic/coffee_bloc/coffee_event.dart';
import 'features/coffee_menu/presentation/screens/coffee_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final apiProvider = CoffeeApiProvider();
  final coffeeRepository = CoffeeRepository(apiProvider: apiProvider);

  runApp(
    RepositoryProvider.value(
      value: coffeeRepository,
      child: BlocProvider(
        create: (context) => CoffeeBloc(repository: coffeeRepository)
          ..add(FetchCoffeeMenuEvent()),
        child: const SelinaCoffeeApp(),
      ),
    ),
  );
}

class SelinaCoffeeApp extends StatelessWidget {
  const SelinaCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Selina Coffee House',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF3E2723),
      ),
      home: const CoffeeHomeScreen(),
    );
  }
}
