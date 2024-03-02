import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car List',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: CarListPage(),
    );
  }
}

class CarListPage extends StatefulWidget {
  @override
  _CarListPageState createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  List<Map<String, dynamic>> cars = List.generate(
    10,
    (index) {
      int carIndex = index + 1;
      return {
        'id': carIndex,
        'name': 'Car $carIndex',
        'year': 2000 + carIndex, // Example year of manufacture
        'price': 10000 + (carIndex * 5000), // Example price
        'image': 'assets/images/car$carIndex.jpg', // Replace with asset image
        'isFavorited': false,
      };
    },
  );

  void toggleFavorite(int id) {
    setState(() {
      final index = cars.indexWhere((car) => car['id'] == id);
      if (index != -1) {
        cars[index]['isFavorited'] = !cars[index]['isFavorited'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car List'),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Cantos arredondados
            ),
            elevation: 4, // Elevação do card
            margin: const EdgeInsets.all(8), // Margem em torno do card
            child: ListTile(
              leading: Image.asset(
                car['image'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(car['name']),
              subtitle: Text('Year: ${car['year']} - Price: \$${car['price']}'),
              trailing: IconButton(
                icon: Icon(
                  car['isFavorited'] ? Icons.favorite : Icons.favorite_border,
                  color: car['isFavorited'] ? Colors.red : null,
                ),
                onPressed: () => toggleFavorite(car['id']),
              ),
            ),
          );
        },
      ),
    );
  }
}
