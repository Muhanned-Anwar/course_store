import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_store/models/product.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/Customer.dart';
import '../../../local/prefs/user_preference_controller.dart';

class FbFireStoreController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  static const String table_users_name = 'Users';

  Future<bool> createUser({required Customer customer}) async {
    return await _fireStore
        .collection(table_users_name)
        .add(customer.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<Customer> readUser({required String id}) async {
    return await _fireStore
        .collection(table_users_name)
        .where('user_id', isEqualTo: id)
        .get()
        .then((value) {
      Customer customer = Customer();
      customer.id = value.docs.first.get('user_id');
      // customer.email = value.docs.first.get('email');
      // customer.password = value.docs.first.get('password');
      customer.username = value.docs.first.get('user_name');
      customer.address = value.docs.first.get('address');
      customer.birthDate = value.docs.first.get('birth_date');
      customer.gender = value.docs.first.get('gender');
      customer.phoneNumber = value.docs.first.get('phone_number');
      customer.profileImage = value.docs.first.get('profile_image');
      customer.documentId = value.docs.first.id;
      print("doc ${value.docs.first.id}");
      return customer;
    }, onError: (e) {
      return Customer();
    });
  }

  Future<bool> updateUser(
      {required BuildContext context, required Customer customer}) async {
    bool secondUpdate = await _fireStore
        .collection(table_users_name)
        .doc(customer.documentId)
        .update(customer.toMap())
        .then((value) => true)
        .catchError((error) => false);

    bool result = secondUpdate;
    if (result) {
      UserPreferenceController().saveUserInformation(
        customer: customer,
        email: UserPreferenceController().userInformation.email,
        password: UserPreferenceController().userInformation.password,
      );
    }

    return result;
  }

  Stream<QuerySnapshot> readOurDemosStream() async* {
    yield* _fireStore.collection('OurDemos').snapshots();
  }

  Stream<QuerySnapshot> readAllCoursesStream() async* {
    yield* _fireStore.collection('Courses').snapshots();
  }

  Stream<QuerySnapshot> readAllLessonsStream() async* {
    yield* _fireStore.collection('lessons').snapshots();
  }

  Stream<QuerySnapshot> readAllProductsStream() async* {
    yield* _fireStore.collection('Products').snapshots();
  }

  Future<bool> addProductToCart(
      {required String productId, required String userId}) async {
    Map<String, dynamic> cart = <String, dynamic>{};
    cart['productId'] = productId;
    cart['userId'] = userId;
    return await _fireStore
        .collection('Carts')
        .add(cart)
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<List<Product>> getProductsCart({required String userId}) async {
    List<Product> products = [];
    return await _fireStore
        .collection('Carts')
        .where('userId', isEqualTo: userId)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        products.add(await getProduct(element.get('productId')));
      }
      return products;
    }, onError: (e) {
      return products;
    });
  }

  Future<Product> getProduct(String productId) async {
    Product product = Product(id: '0', imagePath: '0', title: '0', price: '0');
    return await _fireStore.collection('Products').doc(productId).get().then(
        (value) {
      product = Product(
        id: productId,
        imagePath: value.get('imagePath'),
        title: value.get('title'),
        price: value.get('price'),
      );
      return product;
    }, onError: (e) {
      return product;
    });
  }

  Future<bool> deleteCart(String productId,String userId)async{
    return await _fireStore.collection('Carts').get().then((value){
      for(DocumentSnapshot doc in value.docs){
        if(doc.get('productId') == productId && doc.get('userId') == userId){
          doc.reference.delete();
        }
      }
      return true;
    },onError: (e){
      return false;
    });
  }
}
