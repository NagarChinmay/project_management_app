import 'package:flutter/material.dart';
import 'package:project_management/resource/TextManger.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key, required this.message, required this.fail});
  final bool fail;
  final String message;
  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            widget.fail
                ? Icon(Icons.new_releases,size: 150,color: Colors.redAccent,)
                : Icon(
                    Icons.verified_rounded,
                    size: 150,
                    color: Colors.green,
                  ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 50,horizontal: 10),
                child: Text(
                  widget.message,
                  style: TextManger.message,
                ))
          ],
        ),
      ),
    );
  }
}
