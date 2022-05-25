import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_store/provider/product_provider.dart';
import 'package:course_store/storage/network/firebase/controllers/fb_fire_store_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_drawer/slide_drawer.dart';

import '../models/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late double width;
  late double height;

  List<Product> products = [
    Product(
      id: '0',
      imagePath: 'assets/app/app_images/img1.png',
      title: 'The Earth Ceramic Coffee Mug',
      price: '280',
    ),
    Product(
      id: '1',
      imagePath: 'assets/app/app_images/img2.png',
      title: 'Numeric Flashcard For Kids',
      price: '3.87',
    ),
    Product(
      id: '2',
      imagePath: 'assets/app/app_images/img3.png',
      title: 'Short Love Stories',
      price: '7.74',
    ),
    Product(
      id: '3',
      imagePath: 'assets/app/app_images/img4.png',
      title: 'Time Management',
      price: '7.50',
    ),
    Product(
      id: '4',
      imagePath: 'assets/app/app_images/img5.png',
      title: 'Pink Coffee Mug',
      price: '280',
    ),
    Product(
      id: '5',
      imagePath: 'assets/app/app_images/img6.png',
      title: 'Kids Bed Time Stories',
      price: '280',
    ),
    Product(
      id: '6',
      imagePath: 'assets/app/app_images/img7.png',
      title: 'Relationship Mugs',
      price: '280',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        backgroundColor: const Color(0xffECB7BF),
        title: const Text(
          'Products',
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
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/product_cart_screen');
          }, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width / 39.27,
          vertical: height / 32.145,
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: FbFireStoreController().readAllProductsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                List<QueryDocumentSnapshot> allProducts = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsetsDirectional.only(top: 10),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Provider.of<ProductProvider>(context, listen: false)
                            .changeProduct(
                          product: Product(
                            id: allProducts[index].id,
                            imagePath: allProducts[index].get('imagePath'),
                            title: allProducts[index].get('title'),
                            price: allProducts[index].get('price'),
                            description: allProducts[index].get('description')
                          ),
                        );
                        Navigator.pushNamed(context, '/product_details_screen');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 56, vertical: height / 114.8),
                        margin: EdgeInsetsDirectional.only(
                          bottom: height / 53.57,
                          start: width / 78.54,
                          end: width / 78.54,
                        ),
                        height: height / 9.56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: kElevationToShadow[4],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              allProducts[index].get('imagePath'),
                              width: width / 5.61,
                              height: height / 11.48,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: width / 32.72),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allProducts[index].get('title'),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${allProducts[index].get('price').toString()} KWD',
                                  style: const TextStyle(
                                    color: Color(0xffC99200),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.warning, size: 80),
                      Text(
                        'NOT EXIST ANY QUESTION',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
