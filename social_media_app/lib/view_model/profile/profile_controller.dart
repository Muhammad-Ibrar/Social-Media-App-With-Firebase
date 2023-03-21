import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/res/color.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_manager.dart';


class ProfileController with ChangeNotifier {

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

  bool _loading  = false;
  bool get loading => _loading;

  setLoading ( bool value){
    _loading = value;

    notifyListeners();
  }

  Future pickGalleryImage(BuildContext context) async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery , imageQuality: 100);


    if(pickedFile != null){
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }

  }

  Future pickCameraImage(BuildContext context) async{
    final pickedFile = await picker.pickImage(source: ImageSource.camera , imageQuality: 100);


    if(pickedFile != null){
      _image = XFile(pickedFile.path);
      notifyListeners();
      uploadImage(context);
    }

  }

  void pickImage(context) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: (){
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading:const Icon(Icons.camera_alt , color: AppColors.primaryIconColor,),
                    title:const Text('Camera'),
                  ),
                  ListTile(
                    onTap: (){
                      pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    leading:const Icon(Icons.image , color: AppColors.primaryIconColor,),
                    title:const Text('Gallery'),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void uploadImage(BuildContext context)async{
    setLoading(true);

     firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref('/profileImage'+SessionController().userId.toString()) ;

     firebase_storage.UploadTask uploadTask = storageRef .putFile(File(image!.path).absolute);

     await Future.value(uploadTask);
     final newUrl = storageRef.getDownloadURL();
     
     ref.child(SessionController().userId.toString()).update({

       'Profile' : newUrl.toString()
     }).then((value){
       Utils.toastMessage('Profile Updated');
       setLoading(false);
       _image = null;
     }).onError((error, stackTrace) {
       setLoading(false);
       Utils.toastMessage(error.toString());
     });
  }

  Future<void> showUserNameDialog(BuildContext context , String name) {

    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Update User Name'),
            content: SingleChildScrollView(
              child: Column(
                children: [

                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              },
                  child: Text('Ok')
              ),
              TextButton(onPressed: (){
                Navigator.pop(context);
              },
                  child: Text('Ok')
              ),
            ],
          );
        }
    );
  }
}