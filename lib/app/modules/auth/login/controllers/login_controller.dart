import 'package:dodone/utils/app_utils.dart';
import 'package:dodone/widgets/others/show_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class LoginController extends GetxController {
  RxBool obscurePass = true.obs;

  GoogleSignInAccount? currentUser;
  bool isAuthorized = false; // has granted permissions?
  String contactText = '';

  /// The scopes required by this application.
  static List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  GoogleSignIn googleSignIn = GoogleSignIn(
    // Optional clientId
    // secret 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
    clientId: GetPlatform.isIOS
        ? '595405354893-ji9orud828cgl717ml5aed80625f3l3p.apps.googleusercontent.com'
        : '595405354893-vbel7940fpo1pbnare6vnp5uim5aer9p.apps.googleusercontent.com',
    scopes: scopes,
  );

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  init() {
    googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      // In mobile, being authenticated means being authorized...
      isAuthorized = account != null;
      logSys("Jalan auth awal : $isAuthorized");

      // However, in the web...
      if (kIsWeb && account != null) {
        await googleSignIn
            .canAccessScopes(scopes)
            .then((value) => isAuthorized = value);
        logSys("Jalan auth : $isAuthorized");
      }

      currentUser = account;
      // logSys("User : $currentUser");
      showToast(
        message: currentUser!.displayName.toString(),
        gravity: ToastGravity.TOP_RIGHT,
      );

      // isAuthorized = isAuthorized;
      update();

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        handleGetContact(account!);
      }
    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    googleSignIn.signInSilently();
  }

  // Calls the People API REST endpoint for the signed-in user to retrieve information.
  Future<void> handleGetContact(GoogleSignInAccount user) async {
    contactText = 'Loading contact info...';
    update();

    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      contactText = 'People API gave a ${response.statusCode} '
          'response. Check logs for details.';
      update();
      logSys('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);

    if (namedContact != null) {
      contactText = 'I see you know $namedContact!';
    } else {
      contactText = 'No contacts to display.';
    }
    update();
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
        (dynamic name) =>
            (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  // This is the on-click handler for the Sign In button that is rendered by Flutter.
  //
  // On the web, the on-click handler of the Sign In button is owned by the JS
  // SDK, so this method can be considered mobile only.
  Future<void> handleSignIn() async {
    try {
      logSys("Jalan klik");
      await googleSignIn.signIn().then((value) => logSys('$value'));
    } catch (error) {
      logSys('$error');
    }
  }

  signInClick() {
    try {
      googleSignIn.signOut();
      logSys("Jalan klik");
      googleSignIn.signIn().then((value) {
        logSys('Hasil : $value');
        googleSignIn.signIn();
      });
    } on Exception catch (ex) {
      logSys('Terjadi Exception');
      logSys('$ex'); // Only catches an exception of type `Exception`.
    } catch (error) {
      logSys('Terjadi Error');
      logSys('$error');
    }
  }

  // Prompts the user to authorize `scopes`.
  //
  // This action is **required** in platforms that don't perform Authentication
  // and Authorization at the same time (like the web).
  //
  // On the web, this must be called from an user interaction (button click).
  Future<void> handleAuthorizeScopes() async {
    isAuthorized = await googleSignIn.requestScopes(scopes);
    update();

    if (isAuthorized) {
      handleGetContact(currentUser!);
    }
  }

  Future<void> handleSignOut() => googleSignIn.disconnect();
}
