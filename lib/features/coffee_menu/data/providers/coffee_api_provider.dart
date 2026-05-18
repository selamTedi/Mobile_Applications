import 'package:dio/dio.dart';
import '../models/coffee_model.dart';

class CoffeeApiProvider {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com",
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  // 5 COMPLETELY UNIQUE, HIGH-RES COFFEE IMAGES
  final List<Map<String, String>> _ethiopianCulturePool = [
    {
      "name": "Traditional Jebena Buna",
      "desc":
          "Authentic organic coffee, slow-brewed in a clay Jebena over glowing charcoal, served alongside smoking frankincense (ዕጣን).",
      "img":
          "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500&auto=format&fit=crop"
    },
    {
      "name": "Cloud Macchiato (Ethiopian Style)",
      "desc":
          "A bold, intense shot of locally roasted espresso layered perfectly under a heavy cloud of rich, frothy steamed milk.",
      "img":
          "https://images.unsplash.com/photo-1541167760496-1628856ab772?w=500&auto=format&fit=crop"
    },
    {
      "name": "Kefa Forest Single Origin",
      "desc":
          "Premium wild Arabica harvested from the ancient birthplace of coffee in Keffa, featuring deep floral and citrus undertones.",
      "img":
          "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=500&auto=format&fit=crop"
    },
    {
      "name": "Sidamo Honey Process Espresso",
      "desc":
          "Smooth, medium-bodied espresso pulled from natural Sidamo beans, offering a naturally sweet, rich dark chocolate finish.",
      "img":
          "https://images.unsplash.com/photo-1507133750040-4a8f57021571?w=500&auto=format&fit=crop"
    },
    {
      "name": "Yirgacheffe Spiced Cold Brew",
      "desc":
          "Crisp, refreshing cold brew steeped with delicate Yirgacheffe beans and infused with a subtle hint of traditional cardamom.",
      "img":
          "https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=500&auto=format&fit=crop"
    }
  ];

  Future<List<CoffeeModel>> fetchCoffeesFromApi() async {
    try {
      final response = await _dio.get('/posts?_limit=5');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        int index = 0;

        return data.map((item) {
          // Grabs a completely unique item from our 5 distinct assets
          final cultureItem =
              _ethiopianCulturePool[index % _ethiopianCulturePool.length];
          index++;

          double mockPrice = 40.0 + (index * 15);

          return CoffeeModel(
            id: item['id'].toString(),
            name: cultureItem["name"]!,
            price: mockPrice,
            description: cultureItem["desc"]!,
            imageUrl: cultureItem["img"]!,
          );
        }).toList();
      }
    } catch (e) {
      print("Network loop exception cleanly bypassed: $e");
    }

    // Fail-safe layout
    return _ethiopianCulturePool.asMap().entries.map((entry) {
      int idx = entry.key;
      var item = entry.value;
      return CoffeeModel(
        id: (idx + 1).toString(),
        name: item["name"]!,
        price: 50.0 + (idx * 10),
        description: item["desc"]!,
        imageUrl: item["img"]!,
      );
    }).toList();
  }
}
