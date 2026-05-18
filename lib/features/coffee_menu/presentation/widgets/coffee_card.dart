import 'package:flutter/material.dart';
import '../../data/models/coffee_model.dart';

class CoffeeCard extends StatelessWidget {
  final CoffeeModel coffee;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CoffeeCard({
    super.key,
    required this.coffee,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Coffee Image Block
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                coffee.imageUrl,
                width: 85,
                height: 85,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 85,
                    height: 85,
                    color: const Color(0xFFD7CCC8),
                    child: const Icon(Icons.coffee,
                        color: Color(0xFF4E342E), size: 35),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),

            // Text Details Block
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coffee.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF3E2723)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    coffee.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700], fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${coffee.price.toStringAsFixed(2)} ETB",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),

            // Action Buttons Block (Edit and Confirm Delete)
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit,
                      color: Colors.indigoAccent, size: 22),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_sweep,
                      color: Colors.redAccent, size: 22),
                  onPressed: () {
                    // Triggers the confirmation modal layout
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          backgroundColor: const Color(0xFFFAF6F0),
                          title: const Text(
                            'Confirm Delete',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3E2723)),
                          ),
                          content: Text(
                            'Are you sure you want to remove "${coffee.name}" from the Selina Coffee House menu?',
                            style: const TextStyle(color: Colors.black87),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(dialogContext)
                                    .pop(); // Dismiss popup
                              },
                              child: const Text('Cancel',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent),
                              onPressed: () {
                                Navigator.of(dialogContext)
                                    .pop(); // Close dialog target first
                                onDelete(); // Perform deletion callback operation
                              },
                              child: const Text('Delete',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
