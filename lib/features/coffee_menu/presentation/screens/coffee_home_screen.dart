import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/coffee_model.dart';
import '../../logic/coffee_bloc/coffee_bloc.dart';
import '../../logic/coffee_bloc/coffee_event.dart';
import '../../logic/coffee_bloc/coffee_state.dart';
import '../widgets/coffee_card.dart';

class CoffeeHomeScreen extends StatelessWidget {
  const CoffeeHomeScreen({super.key});

  void _openFormModal(BuildContext context, {CoffeeModel? existingCoffee}) {
    final nameInput = TextEditingController(text: existingCoffee?.name ?? '');
    final priceInput = TextEditingController(
        text: existingCoffee?.price != null
            ? existingCoffee!.price.toString()
            : '');
    final descInput =
        TextEditingController(text: existingCoffee?.description ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFAF6F0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            top: 24,
            left: 24,
            right: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                existingCoffee == null ? 'Add New coffee' : 'Modify Selection',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameInput,
                decoration: const InputDecoration(
                    labelText: 'Coffee Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: priceInput,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Price (ETB)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descInput,
                maxLines: 2,
                decoration: const InputDecoration(
                    labelText: 'Recipe Details', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E342E)),
                  onPressed: () {
                    final title = nameInput.text;
                    final cost = double.tryParse(priceInput.text) ?? 0.0;
                    final notes = descInput.text;

                    if (title.isEmpty || cost <= 0.0) return;

                    if (existingCoffee == null) {
                      final item = CoffeeModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: title,
                        price: cost,
                        description: notes,
                        imageUrl:
                            'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=500',
                      );
                      BlocProvider.of<CoffeeBloc>(context)
                          .add(CreateCoffeeEvent(item));
                    } else {
                      final updated = CoffeeModel(
                        id: existingCoffee.id,
                        name: title,
                        price: cost,
                        description: notes,
                        imageUrl: existingCoffee.imageUrl,
                      );
                      BlocProvider.of<CoffeeBloc>(context)
                          .add(UpdateCoffeeEvent(updated));
                    }
                    Navigator.pop(ctx);
                  },
                  child: Text(
                      existingCoffee == null
                          ? 'Save to Menu'
                          : 'Confirm Updates',
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      appBar: AppBar(
        title: const Text('Selina Coffee House',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.white)),
        backgroundColor: const Color(0xFF3E2723),
        centerTitle: true,
      ),
      body: BlocBuilder<CoffeeBloc, CoffeeState>(
        builder: (context, state) {
          if (state is CoffeeMenuLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFF3E2723)));
          } else if (state is CoffeeMenuLoaded) {
            if (state.menu.isEmpty) {
              return const Center(
                  child: Text('Our menu is expanding. Add items!'));
            }
            return ListView.builder(
              itemCount: state.menu.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemBuilder: (context, index) {
                final drink = state.menu[index];
                return CoffeeCard(
                  coffee: drink,
                  onEdit: () => _openFormModal(context, existingCoffee: drink),
                  onDelete: () {
                    BlocProvider.of<CoffeeBloc>(context)
                        .add(DeleteCoffeeEvent(drink.id));
                  },
                );
              },
            );
          } else if (state is CoffeeMenuError) {
            return Center(child: Text(state.errorMessage));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3E2723),
        child:
            const Icon(Icons.add_circle_outline, color: Colors.white, size: 28),
        onPressed: () => _openFormModal(context),
      ),
    );
  }
}
