import 'package:bubble/bubble.dart';
import 'package:emoji_choose/emoji_choose.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final String name;
   const MessageScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final controller = TextEditingController();
bool isShowSticker = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children:  [
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: const Icon(Icons.arrow_back)),
             const CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage('assets/images/alok.png'),
              ),
              const SizedBox(width: 10,),
              Text(widget.name, style: const TextStyle(fontSize: 16),),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                reverse: true,
                children: [
                  Bubble(
                    margin: const BubbleEdges.only(top: 10),
                    alignment: Alignment.topRight,
                    nip: BubbleNip.rightTop,
                    color: const Color.fromRGBO(225, 255, 199, 1.0),
                    child: const Text('Hello, World!', textAlign: TextAlign.right),
                  ),
                  Bubble(
                    margin: const BubbleEdges.only(top: 10),
                    alignment: Alignment.topLeft,
                    nip: BubbleNip.leftTop,
                    child: const Text('Hi, developer!'),
                  ),
                  Bubble(
                    margin: const BubbleEdges.only(top: 10),
                    alignment: Alignment.topRight,
                    nip: BubbleNip.rightTop,
                    color: const Color.fromRGBO(225, 255, 199, 1.0),
                    child: const Text('Hello, World!', textAlign: TextAlign.right),
                  ),
                  Bubble(
                    margin: const BubbleEdges.only(top: 10),
                    alignment: Alignment.topLeft,
                    nip: BubbleNip.leftTop,
                    child: const Text('Hi, developer!'),
                  ),

                  Bubble(
                    alignment: Alignment.center,
                    color: const Color.fromRGBO(212, 234, 244, 1.0),
                    child: const Text('TODAY', textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0)),
                  ),
                  Bubble(
                    margin: const BubbleEdges.only(top: 10),
                    alignment: Alignment.topRight,
                    nip: BubbleNip.rightTop,
                    color: const Color.fromRGBO(225, 255, 199, 1.0),
                    child: const Text('Hello, World!', textAlign: TextAlign.right),
                  ),
                  Bubble(
                    margin: const BubbleEdges.only(top: 10),
                    alignment: Alignment.topLeft,
                    nip: BubbleNip.leftTop,
                    child: const Text('Hi, developer!'),
                  ),
                  Bubble(
                    margin: const BubbleEdges.only(top: 10),
                    alignment: Alignment.topRight,
                    nip: BubbleNip.rightTop,
                    color: const Color.fromRGBO(225, 255, 199, 1.0),
                    child: const Text('Hello, World!', textAlign: TextAlign.right),
                  ),
                  Bubble(
                    margin: const BubbleEdges.only(top: 10),
                    alignment: Alignment.topLeft,
                    nip: BubbleNip.leftTop,
                    child: const Text('Hi, developer!'),
                  ),

                  Bubble(
                    alignment: Alignment.center,
                    color: const Color.fromRGBO(212, 234, 244, 1.0),
                    child: const Text('YESTERDAY', textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0)),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextField(
                      textInputAction: TextInputAction.send,
                      onEditingComplete: (){
                        controller.clear();
                      },
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      controller: controller,
                      decoration:  InputDecoration(
                      hintText: 'Message',
                      border: InputBorder.none,
                      prefixIcon: IconButton(icon: const Icon(Icons.emoji_emotions_outlined), onPressed:(){
                        hideKeyboard(context);
                        setState(() {
                          isShowSticker = true;
                        });
                      } ,),
                        suffixIcon: IconButton(icon: const Icon(Icons.attach_file), onPressed: () {  },),
                    ),
                    ),
                  ),
                ),

                CircleAvatar(
                    backgroundColor: const Color(0xff64cf43),
                    radius: 23,
                    child: IconButton(onPressed: (){}, icon: const Icon(Icons.send, color: Colors.black,))),
              ],
            ),

            (isShowSticker ? buildSticker() : Container()),

          ],
        ),
      ),
    );
  }

  Widget buildSticker() {
    return EmojiChoose(
        rows: 3,
        columns: 7,
        buttonMode: ButtonMode.MATERIAL,
        numRecommended: 10,
        onEmojiSelected: (emoji, category) {
          controller.text = controller.text + emoji.emoji;
          },
      recommendKeywords: const ["face", "happy", "party", "sad"],
    );
  }
  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

   hideKeyboard(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
