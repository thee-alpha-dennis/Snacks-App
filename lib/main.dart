import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderingapp/provider/cartprovider/cartprovider.dart';
import 'package:orderingapp/screens/navigation.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';

void main() {
  //remain potrait
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const OrderApp());
  });
}

class OrderApp extends StatelessWidget {
  const OrderApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context)=>CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Ordering App',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.alataTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        home: const LetsNavi (),
      ),
    );
  }
}

