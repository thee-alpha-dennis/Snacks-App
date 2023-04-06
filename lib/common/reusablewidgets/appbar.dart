import 'package:flutter/material.dart';
import 'package:orderingapp/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../models/carticonmodel/cartmodel.dart';


AppBar appbar=AppBar(

  leading: Row(
    children: const [

      Padding(
        padding: EdgeInsets.only(left:4),
        child: SizedBox(width:40,height:40,child: Icon(Icons.ac_unit_outlined,size: 40,color: Colors.greenAccent),),
      ),
    ],
  ),
  backgroundColor:apColor,
  title: const Text(
    'Snacks App',
    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  ),
  centerTitle: true,
  actions: const [
    CartStackModel()
  ],
);

