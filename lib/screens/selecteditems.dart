import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/cartdatabasehelper.dart';
import '../provider/cartprovider/cartprovider.dart';

class SelectedItems extends StatefulWidget {
  const SelectedItems ({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectedItems > createState() => _SelectedItemsState();
}

class _SelectedItemsState extends State<SelectedItems > {
  CartDBHelper? dbHelper = CartDBHelper();
  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Selected Snacks',
              style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<CartProvider>(
                builder: (BuildContext context, provider, widget) {
                  if (provider.cart.isEmpty) {
                    provider.getData();
                    return const Center(
                        child: Text(
                          'No Snacks have been selected',
                          style: TextStyle(color: Colors.greenAccent,
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ));
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.cart.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Card(
                              color: Colors.white,
                              elevation: 5.0,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  children: [
                                    Image(
                                      height: 60,
                                      width: 80,
                                      image: AssetImage(
                                          provider.cart[index].imagepath!),
                                    ),
                                    const SizedBox(width: 50,),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: TextSpan(
                                              text: 'Name: ',
                                              style: TextStyle(
                                                  color: Colors
                                                      .blueGrey.shade800,
                                                  fontSize: 14.0),
                                              children: [
                                                TextSpan(
                                                    text:
                                                    '${provider.cart[index].snackName}\n',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold)),
                                              ]),
                                        ),
                                        const SizedBox(height: 10,),
                                        RichText(
                                          maxLines: 1,
                                          text: TextSpan(
                                              text: 'Price: ' r"Kshs. ",
                                              style: const TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 14.0),
                                              children: [
                                                TextSpan(
                                                    text:
                                                    '${provider.cart[index].snackPrice}\n',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold)),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
            ],
        ),
            );
  }
}

