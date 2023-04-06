import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cartprovider/cartprovider.dart';
import '../../screens/cart.dart';

class CartStackModel extends StatelessWidget {
  const CartStackModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart,child){
      return Stack(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart,color: Colors.black),
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name != '/cart') {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen(), settings: RouteSettings(name: '/cart'))
                );
              }
            },
          ),

          if(cart.getCounter()>0)
          Positioned(
            right: 8,
            top: 23,
            child: Container(padding: EdgeInsets.all(1),
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.white)),
              child: Center(
                  child: Text(
                '${cart.getCounter()}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 10),
              )),
            ),
          ),

        ],
      );}
    );
  }
}
