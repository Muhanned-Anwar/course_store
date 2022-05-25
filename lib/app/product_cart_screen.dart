import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_store/storage/local/prefs/user_preference_controller.dart';
import 'package:course_store/storage/network/firebase/controllers/fb_fire_store_controller.dart';
import 'package:course_store/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../provider/main_position_provider.dart';
import '../res/colours.dart';

class ProductCartScreen extends StatefulWidget {
  const ProductCartScreen({Key? key}) : super(key: key);

  @override
  State<ProductCartScreen> createState() => _ProductCartScreenState();
}

class _ProductCartScreenState extends State<ProductCartScreen> with Helpers {
  late double width;
  late double height;
  double subTotal = 0;

  Product product = Product(
    id: '0',
    imagePath: 'assets/app/app_images/img1.png',
    title: 'The Earth Ceramic Coffee Mug',
    price: '280',
  );
  List<Product> products = [];
  List<double> prices = [];

  @override
  void initState() {
    super.initState();
  }

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
            bottomRight: Radius.circular(25),
          ),
        ),
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
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_outlined),
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width / 26.18,
          vertical: height / 32.145,
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              products;
            });
          },
          child: Column(
            children: [
              SizedBox(
                height: products.isNotEmpty ? height / 2 : height / 1.2,
                child: FutureBuilder<List<Product>>(
                    future: FbFireStoreController().getProductsCart(
                        userId: UserPreferenceController().userInformation.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colours.primaryColor,
                          ),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        products = snapshot.data!;
                        subTotal = 0;
                        for (var element in products) {
                          subTotal += double.parse(element.price);
                        }
                        return ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 56,
                                    vertical: height / 114.8),
                                margin: EdgeInsetsDirectional.only(
                                  bottom: height / 53.57,
                                  start: width / 78.54,
                                  end: width / 78.54,
                                ),
                                height: height / 8,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: kElevationToShadow[4],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      products[index].imagePath,
                                      width: width / 5.61,
                                      height: height / 11.48,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: width / 32.72),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              products[index].title,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: width / 50),
                                            IconButton(
                                              onPressed: () async {
                                                bool status =
                                                    await FbFireStoreController()
                                                        .deleteCart(
                                                            products[index].id,
                                                            UserPreferenceController()
                                                                .userInformation
                                                                .id);
                                                print('Products Length = ${products.length}');
                                                if (status) {
                                                  products = await FbFireStoreController().getProductsCart(
                                                      userId: UserPreferenceController().userInformation.id);
                                                  showSnackBar(
                                                      context: context,
                                                      message:
                                                          'Deleted Successfully');
                                                  setState(() {
                                                    subTotal = 0;
                                                    for (var element in products) {
                                                      subTotal += double.parse(element.price);
                                                    }
                                                  });
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.delete_outlined,
                                                color: Colours.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              products[index].price.toString(),
                                              style: const TextStyle(
                                                color: Color(0xffC99200),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            SizedBox(width: width / 4.13),
                                            Container(
                                              width: width / 3.6,
                                              height: height / 30,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade300),
                                              ),
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.remove,
                                                      color: Colors.grey,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  const Text(
                                                    '2',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.add,
                                                      color: Colors.grey,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            });
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Image.asset(
                                  'assets/app/app_images/empty_cart.png'),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 5.454),
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
                                minimumSize: Size(width / 1.57, height / 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                primary: const Color(0xffECB7BF),
                              ),
                              onPressed: () {
                                Provider.of<MainPositionProvider>(context, listen: false)
                                    .changePosition(position: 2);
                                Navigator.pushReplacementNamed(context, '/main_screen');                              },
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
                        );
                      }
                    }),
              ),
              // SizedBox(height: height / 33.484),
              Visibility(
                visible: products.isNotEmpty,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sub total:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              Text(
                                '$subTotal KWD',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height / 73),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Tax (15%):',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              Text(
                                '15 KWD',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height / 73),
                          const Divider(color: Colors.grey),
                          SizedBox(height: height / 73),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${subTotal - (subTotal * 0.15)} KWD',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height / 73),
                          const Divider(color: Colors.grey),
                        ],
                      ),
                    ),
                    SizedBox(height: height / 30.9),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(345, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        primary: const Color(0xffECB7BF),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'CHECKOUT',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
