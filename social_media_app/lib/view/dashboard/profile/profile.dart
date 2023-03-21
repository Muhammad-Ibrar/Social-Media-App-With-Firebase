import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view_model/profile/profile_controller.dart';
import 'package:tech_media/view_model/services/session_manager.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final ref = FirebaseDatabase.instance.ref('User');

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:ChangeNotifierProvider(
        create: (_) => ProfileController(),
        child: Consumer<ProfileController>(
          builder: (context , provider , child) {
            return  SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: StreamBuilder(
                    stream: ref.child(SessionController().userId.toString()).onValue,
                    builder: (context,AsyncSnapshot snapshot) {
                      if(!snapshot.hasData) {
                        return const Center(
                            child: CircularProgressIndicator()
                        );
                      }
                      else if(snapshot.hasData){
                        Map<dynamic,dynamic> map = snapshot.data.snapshot.value;
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: AppColors.secondaryTextColor,
                                              width: 3
                                          )
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),

                                        child: provider.image == null ? map['profile'].toString() == " " ? Icon(Icons.person_outline) :Image(
                                          fit: BoxFit.cover,
                                          image:const NetworkImage(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_0YktZumnDWz05vaoM9zkHdSjYj21A7_38A&usqp=CAU'
                                          ) ,

                                          loadingBuilder: (context , child , loadingProgress){
                                            if(loadingProgress == null){
                                              return child;
                                            }
                                            return const Center(
                                                child: CircularProgressIndicator()
                                            );
                                          },
                                          errorBuilder: (context , object , stack){
                                            return Container(
                                                child:const Icon(Icons.error_outline_rounded , color: AppColors.alertColor)
                                            );
                                          },
                                        ):

                                            Stack(
                                              children: [
                                                Image.file(
                                                    File(provider.image!.path).absolute
                                                ),
                                                const Center(
                                                  child: CircularProgressIndicator(),
                                                )
                                              ],
                                            )
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    provider.pickImage(context);
                                  },
                                  child: const CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.secondaryTextColor,
                                    child: Icon(Icons.add , color: Colors.white,),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 40),
                            GestureDetector(
                              onTap: (){
                                provider.showUserNameDialog(context, map['userName']);
                              },
                                child: ReusableRow(title: 'UserName', value: map['userName'], iconData: Icons.person)

                            ),
                            ReusableRow(title: 'Phone', value: map['phone'] == '' ? '123-456-7890' : map['phone'] , iconData: Icons.phone),
                            ReusableRow(title: 'Email', value: map['email'], iconData: Icons.email_outlined),

                          ],
                        );

                      }
                      else {
                        return Text('Something went wrong' , style: Theme.of(context).textTheme.subtitle1,);
                      }

                    },

                  )
              ),
            );
          },
        ),

      )

    );
  }
}


class ReusableRow extends StatelessWidget {
  final String title , value;
  final IconData iconData;

  const ReusableRow({Key? key , required this.title , required this.value , required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title:  Text(title),
          leading: Icon(iconData),
          trailing: Text(value),
        ),
        Divider(color: AppColors.dividedColor)
      ],
    );
  }
}
