import 'package:alloha/data/model/response/auth_response.dart';
import 'package:alloha/data/model/response/base/api_response.dart';
import 'package:alloha/data/repositry/auth_rebo.dart';
import 'package:alloha/helper/compenents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _loginErrorMessage = '';

  String get loginErrorMessage => _loginErrorMessage;

  Future<AuthResponse> login(String email, String password) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse =
        await authRepo.login(email: email, password: password);
    AuthResponse responseModel;
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      Map map = apiResponse.response?.data;
      String token = map["access_token"];
      authRepo.saveUserToken(token);
      responseModel = AuthResponse(true, token);
    } else {
      String errorMessage;
      errorMessage = apiResponse.message.toString();

      print("Error  " + errorMessage);
      _loginErrorMessage = "errorMessage";
      responseModel = AuthResponse(false, _loginErrorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        _isLoading = false;
        notifyListeners();
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          showError(context,
              "The account already exists with a different credential.");
        } else if (e.code == 'invalid-credential') {
          showError(context,
              "Error occurred while accessing credentials. Try again.");
        }
      } catch (e) {
        showError(context, "Error occurred using Google Sign-In. Try again.");
      }
    }

    return user;
  }

  Future<dynamic> signInWithFacebook() async {
    // Trigger the sign-in flow
    _isLoading = true;
    notifyListeners();
    final LoginResult loginResult = await FacebookAuth.instance.login();

    _isLoading = false;
    notifyListeners();
    if (!loginResult.status.name.contains("success")) {
      // return throw Exception('${loginResult.message}');
      return Future.error('${loginResult.message}');
    }
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
