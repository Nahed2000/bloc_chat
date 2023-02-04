import 'package:flutter/material.dart';

class MessageText extends StatelessWidget {
  const MessageText({
    Key? key,
    required this.sender,
    required this.text,
    required this.isME,
  }) : super(key: key);

  final String text;
  final String sender;
  final bool isME;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment:
          isME ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style:  TextStyle(
                color: Colors.orange.shade900,
                fontSize: 12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: 120,
                height: 75,
                child: Material(
                  color: isME ? Colors.blue[800] : Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: isME ? const Radius.circular(30) : const Radius.circular(0),
                      topRight: isME ? const Radius.circular(0) : const Radius.circular(30),
                      bottomLeft: const Radius.circular(30),
                      bottomRight: const Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      text,
                      style:  TextStyle(color:isME?Colors.white:Colors.blue[800], fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}