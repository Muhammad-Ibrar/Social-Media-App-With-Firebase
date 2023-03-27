import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_manager.dart';


class MessageScreen extends StatefulWidget {
  final String name , image , email , receiverId;
  const MessageScreen({
    Key? key ,
    required this.name ,
    required this.image ,
    required this.email,
    required this.receiverId
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  final DatabaseReference ref = FirebaseDatabase.instance.ref().child('chat');
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: 10,
                  itemBuilder: (context , index){
                    return Text(index.toString());
          })),
          Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextFormField(
                        controller: messageController,

                        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: 'Enter Message',
                          suffixIcon:InkWell(
                            onTap: (){
                              sendMessage();
                            },
                            child: const  Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: CircleAvatar(
                                backgroundColor: AppColors.primaryIconColor,
                                child: Icon(Icons.send , color: Colors.white,),
                              ),
                            ),
                          ),
                          hintStyle: Theme.of(context).textTheme.bodyText2,
                          border:const OutlineInputBorder(
                            borderSide: BorderSide(
                              color:AppColors.textFieldDefaultFocus,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder:const OutlineInputBorder(
                            borderSide: BorderSide(
                              color:AppColors.secondaryColor,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          errorBorder:const OutlineInputBorder(
                            borderSide: BorderSide(
                              color:AppColors.alertColor,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder:const OutlineInputBorder(
                            borderSide: BorderSide(
                              color:AppColors.textFieldDefaultBorderColor,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),

                        )
                    ),
                  )
              ),

            ],
          )
        ],
      ),
    );
  }

  sendMessage(){

    if(messageController.text.isEmpty){
      Utils.toastMessage('Enter Message');
    }
    else {
      final time = DateTime.now().millisecondsSinceEpoch.toString();
      ref.child(time).set({
        'isSeen' : false,
        'message' : messageController.text.toString(),
        'sender' : SessionController().userId.toString(),
        'receiver' : widget.receiverId,
        'type' : 'text',
        'time' : time.toString()
      }).then((value){
        messageController.clear();
      });

    }

  }

}
