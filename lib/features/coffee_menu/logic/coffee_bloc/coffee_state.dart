import 'package:equatable/equatable.dart';
import '../../data/models/coffee_model.dart';

abstract class CoffeeState extends Equatable {
  const CoffeeState();

  @override
  List<Object?> get props => [];
}

class CoffeeMenuInitial extends CoffeeState {}

class CoffeeMenuLoading extends CoffeeState {}

class CoffeeMenuLoaded extends CoffeeState {
  final List<CoffeeModel> menu;
  const CoffeeMenuLoaded(this.menu);

  @override
  List<Object?> get props => [menu];
}

class CoffeeMenuError extends CoffeeState {
  final String errorMessage;
  const CoffeeMenuError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
