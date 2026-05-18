import 'package:equatable/equatable.dart';
import '../../data/models/coffee_model.dart';

abstract class CoffeeEvent extends Equatable {
  const CoffeeEvent();

  @override
  List<Object?> get props => [];
}

class FetchCoffeeMenuEvent extends CoffeeEvent {}

class CreateCoffeeEvent extends CoffeeEvent {
  final CoffeeModel coffee;
  const CreateCoffeeEvent(this.coffee);

  @override
  List<Object?> get props => [coffee];
}

class UpdateCoffeeEvent extends CoffeeEvent {
  final CoffeeModel coffee;
  const UpdateCoffeeEvent(this.coffee);

  @override
  List<Object?> get props => [coffee];
}

class DeleteCoffeeEvent extends CoffeeEvent {
  final String id;
  const DeleteCoffeeEvent(this.id);

  @override
  List<Object?> get props => [id];
}
