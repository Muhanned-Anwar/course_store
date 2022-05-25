import 'package:course_store/provider/product_provider.dart';
import 'package:course_store/res/colours.dart';
import 'package:course_store/storage/local/prefs/user_preference_controller.dart';
import 'package:course_store/storage/network/firebase/controllers/fb_fire_store_controller.dart';
import 'package:course_store/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../models/product.dart';
import '../widgets/page_view_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with Helpers{
  late double width;
  late double height;

  late PageController _imagePageController;
  int _currentImageIndex = 0;

//   Product product = Product(
//     id: '0',
//     imagePath: 'assets/app/app_images/img.png',
//     title: 'The Earth Ceramic Coffee Mug',
//     price: '280',
//     description:
//         '''It is a long established fact that a reader
// will be distracted by the readable content
// of a page when looking at its layout.
// The point of using Lorem Ipsum is that
//  it has a more-or-less normal distribution of letters,
//  as opposed to using 'Content here, content here', making it look like readable English.''',
//   );

  @override
  void initState() {
    _imagePageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _imagePageController.dispose();
  }

  int itemCount = 1;
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
          'Product Detail',
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/product_cart_screen');
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: height / 3.4197,
            margin: EdgeInsetsDirectional.only(top: height / 32.145),
            child: Column(
              children: [
                Container(
                  height: height / 3.9,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: _imagePageController,
                    onPageChanged: (int value) {
                      setState(() {
                        _currentImageIndex = value;
                      });
                    },
                    children: [
                      Container(
                        width: width / 1.3,
                        margin: EdgeInsets.symmetric(horizontal: width / 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(
                                  Provider.of<ProductProvider>(context)
                                      .product
                                      .imagePath),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Container(
                        width: width / 1.3,
                        margin: EdgeInsets.symmetric(horizontal: width / 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                                Provider.of<ProductProvider>(context)
                                    .product
                                    .imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: width / 1.3,
                        margin: EdgeInsets.symmetric(horizontal: width / 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                                Provider.of<ProductProvider>(context)
                                    .product
                                    .imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: width / 1.3,
                        margin: EdgeInsets.symmetric(horizontal: width / 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                                Provider.of<ProductProvider>(context)
                                    .product
                                    .imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 1),
                Container(
                  height: height / 80,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      PageViewIndicator(
                        selected: _currentImageIndex == 0,
                        marginEnd: 8,
                        elseColor: Colors.pink.shade100,
                        color: Colors.pink,
                      ),
                      PageViewIndicator(
                        selected: _currentImageIndex == 1,
                        marginEnd: 8,
                        elseColor: Colors.pink.shade100,
                        color: Colors.pink,
                      ),
                      PageViewIndicator(
                        selected: _currentImageIndex == 2,
                        marginEnd: 8,
                        elseColor: Colors.pink.shade100,
                        color: Colors.pink,
                      ),
                      PageViewIndicator(
                        selected: _currentImageIndex == 3,
                        marginEnd: 8,
                        elseColor: Colors.pink.shade100,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: width / 26.18,
                right: width / 26.18,
                top: height / 32.145,
              ),
              height: height / 1.46,
              child: ListView(
                children: [
                  Text(
                    Provider.of<ProductProvider>(context).product.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${Provider.of<ProductProvider>(context).product.price.toString()}0 KWD',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffC99200),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 32.145),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width / 3.6,
                        height: height / 26.78,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: kElevationToShadow[4],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() {
                                  if(itemCount > 1){
                                    itemCount--;
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              itemCount.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() {
                                  if(itemCount < 100){
                                    itemCount++;
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: height / 32.145),
                  SizedBox(
                    height: height / 4.297,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About product',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height / 73.05),
                        Text(
                          Provider.of<ProductProvider>(context)
                              .product
                              .description,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
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
          Container(
            width: double.infinity,
            height: height / 10,
            padding: EdgeInsets.symmetric(
              vertical: height / 53.57,
              horizontal: width / 26.18,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: kElevationToShadow[4],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(345, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                primary: const Color(0xffECB7BF),
              ),
              onPressed: () => performAddToCart(
                  Provider.of<ProductProvider>(context,listen: false).product.id),
              child: const Text(
                'ADD TO CART',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future performAddToCart(String productId) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colours.primaryColor,
        ),
      ),
    );
    bool status = await FbFireStoreController().addProductToCart(
        productId: productId,
        userId: UserPreferenceController().userInformation.id);
    Navigator.pop(context);
    if(status){
      showSnackBar(context: context, message: 'Added To Cart Successfully');
    }else{
      showSnackBar(context: context, message: 'Added To Cart Successfully');
    }
  }
}
