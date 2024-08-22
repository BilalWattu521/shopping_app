import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {

  final shoe;

  const ProductDetailsPage({
    super.key,
    required this.shoe,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  
  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
              title: const Text(
                'Details',
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                widget.shoe['name'],
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
              ),
            ),
            const Spacer(),
            Image.asset(widget.shoe['image']),
            const Spacer(),
            SizedBox(
              height: 200,
              child: Container(
                color:const Color.fromRGBO(245, 247, 249, 1),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      widget.shoe['price'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (widget.shoe['sizes'] as List<int>).length,
                        itemBuilder: (context, index){
                          final size = (widget.shoe['sizes'] as List<int>)[index]; 
                          return GestureDetector(
                            onTap:() {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                            child: Chip(
                              label: Text(
                                size.toString(),
                              ),
                              backgroundColor: selectedSize == size
                              ? Theme.of(context).colorScheme.primary
                              : const Color.fromRGBO(245, 247, 249, 1),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
                      ),
                      onPressed: (){
                        if(selectedSize != 0){
                          Provider.of<CartProvider>(context, listen: false).addProduct(
                            {
                              'brand': widget.shoe['brand'],
                              'name': widget.shoe['name'],
                              'price': widget.shoe['price'],
                              'sizes': selectedSize,
                              'image': widget.shoe['image'],
                            }
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Product added successfully!'),
                            ), 
                          );
                        } else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a size!'),
                            ), 
                          );
                        }
                      }, 
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20,),
                          Text(
                            'Add to Cart',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}