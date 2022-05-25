import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/Customer.dart';

class UserPreferenceController {
  static final UserPreferenceController _instance =
      UserPreferenceController._internal();

  late SharedPreferences _sharedPreferences;

  UserPreferenceController._internal();

  factory UserPreferenceController() {
    return _instance;
  }

  Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveUserInformation({
   required Customer customer,
   required String email,
   required String password,
  }) async {
    _sharedPreferences.setString('id', customer.id);
    _sharedPreferences.setString('email', email);
    _sharedPreferences.setString('password', password);
    _sharedPreferences.setString('username', customer.username);
    _sharedPreferences.setString('address', customer.address);
    _sharedPreferences.setString('birthDate', customer.birthDate);
    _sharedPreferences.setString('gender', customer.gender);
    _sharedPreferences.setString('phoneNumber', customer.phoneNumber);
    _sharedPreferences.setString('document_id', customer.documentId);
    _sharedPreferences.setString('profile_image', customer.profileImage);
  }

  Future<void> updatePassword(String password) async {
    _sharedPreferences.setString('password', password);
  }

  Customer get userInformation {
    Customer customer = Customer();
    customer.id = _sharedPreferences.getString('id')!;
    customer.email = _sharedPreferences.getString('email')!;
    customer.password = _sharedPreferences.getString('password')!;
    customer.username = _sharedPreferences.getString('username')!;
    customer.address = _sharedPreferences.getString('address')!;
    customer.birthDate = _sharedPreferences.getString('birthDate')!;
    customer.gender = _sharedPreferences.getString('gender')!;
    customer.phoneNumber = _sharedPreferences.getString('phoneNumber')!;
    customer.documentId = _sharedPreferences.getString('document_id')!;
    customer.profileImage = _sharedPreferences.getString('profile_image')!;

    return customer;
  }

  Future<void> saveQrLogin() async {
    _sharedPreferences.setBool('logged_in_qr', true);
  }

  bool get loggedInQr => _sharedPreferences.getBool('logged_in_qr') ?? false;

  Future<bool> logout() async {
    return await _sharedPreferences.clear();
  }
}
