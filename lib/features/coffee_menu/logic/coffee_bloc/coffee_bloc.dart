import 'package:flutter_bloc/flutter_bloc.dart';
import 'coffee_event.dart';
import 'coffee_state.dart';
import '../../data/repositories/coffee_repository.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  final CoffeeRepository repository;

  CoffeeBloc({required this.repository}) : super(CoffeeMenuInitial()) {
    on<FetchCoffeeMenuEvent>((event, emit) async {
      emit(CoffeeMenuLoading());
      try {
        final items = await repository.getCoffeeMenu();
        emit(CoffeeMenuLoaded(List.from(items)));
      } catch (e) {
        emit(const CoffeeMenuError("Failed to fetch coffee catalog."));
      }
    });

    on<CreateCoffeeEvent>((event, emit) async {
      await repository.addCoffeeItem(event.coffee);
      final currentMenu = await repository.getCoffeeMenu();
      emit(CoffeeMenuLoaded(List.from(currentMenu)));
    });

    on<UpdateCoffeeEvent>((event, emit) async {
      await repository.updateCoffeeItem(event.coffee);
      final currentMenu = await repository.getCoffeeMenu();
      emit(CoffeeMenuLoaded(List.from(currentMenu)));
    });

    on<DeleteCoffeeEvent>((event, emit) async {
      await repository.deleteCoffeeItem(event.id);
      final currentMenu = await repository.getCoffeeMenu();
      emit(CoffeeMenuLoaded(List.from(currentMenu)));
    });
  }
}
