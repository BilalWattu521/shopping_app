import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: 46,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index){
          final cartItem = cart[index];
          return ListTile(
            title: Text(
              cartItem['name'].toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Size: ${cartItem['sizes']}'),
            leading: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(
                cartItem['image'].toString()
              ),
            ),
            trailing: GestureDetector(
              onTap: (){
                showDialog(
                  context: context, 
                  builder: (context){
                    return AlertDialog(
                      title: const Text(
                        'Delete Product',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: const Text('Are you sure?'),
                      actions: [
                        TextButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          }, 
                          child: const Text(
                            'No',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            Provider.of<CartProvider>(context, listen: false).removeProduct(cartItem);
                            Navigator.of(context).pop();
                          }, 
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                );
              },
              child: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
            ),
          );
        }
      ),
    );
  }
}