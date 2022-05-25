import 'package:flutter/material.dart';
import 'package:slide_drawer/slide_drawer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    print('Width = $width');
    print('Height = $height');

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        backgroundColor: const Color(0xffECB7BF),
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                SlideDrawer.of(context)?.toggle();
              },
              icon: const Icon(Icons.dehaze_rounded),
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/app/app_images/empty_cart.png'),
          ),
          SizedBox(height: height / 22.323),
          const Text(
            'Whoops!',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height / 33.48),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width/5.454),
            child: const Text(
              'Your cart is empty now. Check our products and buy it.!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: height / 33.48),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(width/1.57, height/16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              primary: const Color(0xffECB7BF),
            ),
            onPressed: () {},
            child: const Text(
              'ADD TO CART',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
