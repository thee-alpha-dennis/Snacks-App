

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/reusablewidgets/appbar.dart';
import '../database/cartdatabasehelper.dart';
import '../database/snackdbhelper.dart';
import '../models/cartitemmodel.dart';
import '../provider/cartprovider/cartprovider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
        key: _scaffoldKey,
        appBar: appbar,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 15,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: const Icon(Icons.menu, color: Colors.orangeAccent),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Snacks In Cart',
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
                          'No Snacks in cart, Go to menu page to add ',
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
                                      height: 25,
                                      width: 25,
                                      image: AssetImage(
                                          provider.cart[index].imagepath!),
                                    ),
                                    SizedBox(width: 10,),
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
                                                    fontSize: 11.0),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                      '${provider.cart[index].snackName}\n',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                ]),
                                          ),

                                          RichText(
                                            maxLines: 1,
                                            text: TextSpan(
                                                text: 'Price: ' r"Kshs. ",
                                                style: const TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 12.0),
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

                                    ValueListenableBuilder<int>(
                                        valueListenable:
                                        provider.cart[index].quantity!,
                                        builder: (context, val, child) {
                                          return PlusMinusButtons(
                                            addQuantity: () async {
                                              DatabaseHelper db =
                                              DatabaseHelper();
                                              cart.addQuantity(provider
                                                  .cart[index].snackId!);
                                              dbHelper!
                                                  .updateQuantity(Cart(
                                                  snackId: index,
                                                  snackName: provider
                                                      .cart[index]
                                                      .snackName,
                                                  snackPrice: provider
                                                      .cart[index]
                                                      .snackPrice,
                                                  quantity: ValueNotifier(
                                                      provider.cart[index]
                                                          .quantity!.value),
                                                  imagepath: provider
                                                      .cart[index].imagepath))
                                                  .then((value) {
                                                setState(() {
                                                  cart.addTotalPrice(
                                                      double.parse(provider
                                                          .cart[index]
                                                          .snackPrice
                                                          .toString()));
                                                });
                                              });
                                            },
                                            deleteQuantity: () {
                                              cart.deleteQuantity(provider
                                                  .cart[index].snackId!);
                                              cart.removeTotalPrice(
                                                  double.parse(provider
                                                      .cart[index].snackPrice
                                                      .toString()));
                                            },
                                            text: val.toString(),
                                          );
                                        }),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      (provider.cart[index].snackName!).toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.orange)),
                                                  content: Text(
                                                      'Do you really want to remove ${provider.cart[index].snackName!} ?',
                                                      style:
                                                      const TextStyle(color: Colors.lightGreen,
                                                          fontSize:
                                                          20)),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context);
                                                      },
                                                      child: const Text(
                                                          'Cancel'),
                                                    ),

                                                    TextButton(
                                                      onPressed: () async {
                                                        dbHelper!.deleteCartItem(
                                                            provider
                                                                .cart[index]
                                                                .snackId!);
                                                        provider.removeItem(
                                                            provider
                                                                .cart[index]
                                                                .snackId!);
                                                        provider
                                                            .removeCounter();
                                                        Navigator.pop(
                                                            context);
                                                        ScaffoldMessenger
                                                            .of(context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Center(
                                                              child: Text(
                                                                'Removed from cart...',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                            Colors
                                                                .lightGreenAccent,
                                                            duration:
                                                            Duration(
                                                                seconds:
                                                                1),
                                                          ),
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Remove',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              })
                                              .then((value) =>
                                          const CartScreen());
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red.shade800,
                                        )),
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
            // const Calculation(),
            Consumer<CartProvider>(
              builder: (BuildContext context, value, Widget? child) {
                final ValueNotifier<double> totalPrice = ValueNotifier(0);

                for (var element in value.cart) {
                  double itemPrice = element.snackPrice!;
                  int itemQuantity = element.quantity!.value;
                  totalPrice.value+=itemPrice*itemQuantity;
                }

                return ValueListenableBuilder<double>(
                  valueListenable: totalPrice,
                  builder: (context, val, child) {
                    return Column(
                      children: [
                        ReusableWidget(
                            title: 'Total:',
                            value: r'Kshs. ' + val.toStringAsFixed(2)),

                      ],
                    );
                  },
                );
              },
            ),
            Text('    '),
            Text('    '),
          ],
        ),
        bottomNavigationBar: Consumer<CartProvider>(
            builder: (BuildContext context, provider, widget) {
              return InkWell(
                onTap: () async {
                  if (provider.cart.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'No Snacks in cart.',
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  } else {
                    CartProvider cart = CartProvider();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Center(
                          child: Text(
                            'Snacks purchased successfully...',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        backgroundColor: Colors.lightGreenAccent,
                        duration: Duration(seconds: 3),
                      ),
                    );
                    Navigator.pop(context);
                    cart.clearCart();
                    final cartDbHelper = CartDBHelper();
                    await cartDbHelper.clearCart();

                  }
                },
                child: Container(
                  color: Colors.green,
                  alignment: Alignment.center,
                  height: 40.0,
                  child: const Text(
                    'Complete Purchase',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }));
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key? key,
        required this.addQuantity,
        required this.deleteQuantity,
        required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          IconButton(
              onPressed: deleteQuantity,
              icon: const Icon(Icons.remove),
              color: Colors.orange),
          Text(text,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          IconButton(
              onPressed: addQuantity,
              icon: const Icon(Icons.add),
              color: Colors.orange),
        ],
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget(
      {super.key,
        required this.title,
        required this.value,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
          ),
          Text(
            value.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                fontSize: 18),
          ),
        ],
      ),
    );
  }
}
