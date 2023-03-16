import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';

class LoginController with ChangeNotifier{

  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading  = false;
  bool get loading => _loading;

  setLoading ( bool value){
    _loading = value;

    notifyListeners();
  }

  void login(BuildContext context , String email , String password) {

    setLoading(true);

    try {
      auth.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value){

        setLoading(false);
        Navigator.pushNamed(context, RouteName.dashboardScreen);


      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    }
    catch (e){
      Utils.toastMessage(e.toString());
      setLoading(false);
    }


  }
}