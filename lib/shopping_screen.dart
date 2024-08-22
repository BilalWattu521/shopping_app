import 'package:flutter/material.dart';
import 'package:shopping_app/product_card.dart';
import 'package:shopping_app/product_details_page.dart';
import 'package:shopping_app/shoes.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  
  final List<String> filters = const ['All','Adidas','Bata','Jordan','Nike'];
  late String selectedFilter;

  String searchQuery = '';

  List<Map<String, dynamic>> filteredShoes = [];

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
    filteredShoes = shoes; // Initially, display all shoes
  }

  void filterProducts() {
    setState(() {
      if (selectedFilter == 'All') {
        filteredShoes = shoes;
      } else {
        filteredShoes = shoes.where((shoe) => shoe['brand'] == selectedFilter).toList();
      }
      if (searchQuery.isNotEmpty) {
        filteredShoes = filteredShoes.where((shoe) =>
            shoe['name'].toLowerCase().contains(searchQuery.toLowerCase())).toList();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'Shoes Collection',
               style: TextStyle(
                fontSize: 46,
                fontWeight: FontWeight.bold,
               ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                ),
                onChanged: (value){
                  searchQuery = value;
                  filterProducts();
                },
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index){
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                          filterProducts();
                        });
                      },
                      child: Chip(
                        backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                        side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelStyle: const TextStyle(
                          fontSize: 20,
                        ),
                        label: Text(
                          filter,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredShoes.length,
                itemBuilder: (context, index){
                  final shoe = filteredShoes[index];
                  return GestureDetector(
                    child: ProductCard(
                      name: shoe['name'],
                      price: shoe['price'],
                      image: shoe['image'],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(shoe: shoe),
                        ),
                      );
                    }
                  );
                }
              ),
            )
          ],
        ), 
      ),
    );
  }
}
