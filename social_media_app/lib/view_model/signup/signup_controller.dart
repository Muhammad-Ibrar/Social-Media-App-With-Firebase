import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class SignUpController with ChangeNotifier{

  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  bool _loading  = false;
  bool get loading => _loading;

  setLoading ( bool value){
    _loading = value;

    notifyListeners();
  }

   void signUp(BuildContext context , String userName , String email , String password) {

    setLoading(true);

    try {
      auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((value){
        SessionController().userId = value.user!.uid.toString();
        ref.child(value.user!.uid.toString()).set({

          'uid' : value.user!.uid.toString(),
          'email' : value.user!.email.toString(),
          'phone' : '',
          'userName' : userName,
          'profile image' : ''

        }).then((value) {
          setLoading(false);
          Navigator.pushNamed(context, RouteName.dashboardScreen);

        }).onError((error, stackTrace){

          setLoading(false);

        });
        Utils.toastMessage('User Added');
        setLoading(false);
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