import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'welcome_back': 'Welcome Back!',
          'login_subtitle':
              'Save time and boost your productivity using our powerful features.'
        },
        'id_ID': {
          'welcome_back': 'Selamat Datang Kembali',
        },
      };
}
