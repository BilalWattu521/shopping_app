import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

  final name;
  final price;
  final image;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
      child: SizedBox(
        height: 380,
        child: Card(
          color: const Color.fromARGB(255, 143, 180, 210),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Center(
                  child: Image.asset(image)
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}