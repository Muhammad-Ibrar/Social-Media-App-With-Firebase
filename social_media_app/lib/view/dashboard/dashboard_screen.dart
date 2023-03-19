import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/dashboard/profile/profile.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final Controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreen(){


    return [
      SafeArea(
        child: Text('Home' , style: Theme.of(context).textTheme.subtitle1,)
    ),
      SafeArea(
          child: Text('Chat', style: Theme.of(context).textTheme.subtitle1,)
      ),
      SafeArea(
          child: Text('Add', style: Theme.of(context).textTheme.subtitle1,)
      ),
      SafeArea(
          child: Text('Message', style: Theme.of(context).textTheme.subtitle1,)
      ),
     ProfileScreen()

    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem(){
    return [
      PersistentBottomNavBarItem(
          icon:const Icon(Icons.home_rounded),
        inactiveIcon: Icon(Icons.home_rounded , color: Colors.grey.shade100,)
      ),
      PersistentBottomNavBarItem(
        icon:const Icon(Icons.chat),
          inactiveIcon: Icon(Icons.chat , color: Colors.grey.shade100,)
      ),
      PersistentBottomNavBarItem(
        icon:const Icon(Icons.add),
          inactiveIcon: Icon(Icons.add , color: Colors.grey.shade100,)
      ),
      PersistentBottomNavBarItem(
        icon:const Icon(Icons.message_outlined),
          inactiveIcon: Icon(Icons.message_outlined , color: Colors.grey.shade100,)
      ),
      PersistentBottomNavBarItem(
        icon:const Icon(Icons.person),
          inactiveIcon: Icon(Icons.person , color: Colors.grey.shade100,)
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     automaticallyImplyLeading: true,
    //   ),
    // );
    return PersistentTabView(
      context,
      screens : _buildScreen(),
      items : _navBarItem(),
      backgroundColor: AppColors.otpHintColor,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(1)
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
