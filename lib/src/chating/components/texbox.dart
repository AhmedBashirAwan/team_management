import 'package:flutter/material.dart';
import 'package:team_management/src/auth/register/register.dart';

class CustomTextBox extends StatefulWidget {
  final Function(String) onSendMessage;

  const CustomTextBox({Key? key, required this.onSendMessage})
      : super(key: key);

  @override
  State<CustomTextBox> createState() => _CustomTextBoxState();
}

class _CustomTextBoxState extends State<CustomTextBox> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final String message = _textEditingController.text.trim();
    if (message.isNotEmpty) {
      widget.onSendMessage(message);
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(40)),
        height: getHeight(context) * 0.09,
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextField(
                onSubmitted: (value) {},
                controller: _textEditingController,
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.blue,
                decoration: const InputDecoration(
                  hintText: 'Your Message.',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.attach_file),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
