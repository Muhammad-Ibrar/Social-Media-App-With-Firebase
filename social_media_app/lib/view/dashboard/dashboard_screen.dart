import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(SessionController().userId.toString()),
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth auth = FirebaseAuth.instance;
            auth.signOut().then((value){
              SessionController().userId = '';
              Navigator.pushNamed(context, RouteName.loginView);
            });

          },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(
        children:[

        ],
      ),
    );
  }
}
