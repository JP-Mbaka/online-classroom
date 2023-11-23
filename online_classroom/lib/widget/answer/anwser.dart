import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnswerCard extends StatefulWidget {
  Color? iconColor, color;

  String? value;

  String? answer;

  AnswerCard({super.key, this.answer, this.iconColor, this.color});

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {
  bool isTrueFalse = false;

  bool isMultiple = false;

  bool isDiscussion = false;

  bool isUpload = false;

  Key? clickedKey;

  Color? textColor;

  _onSelectAnswer() {
    print(widget.key);
    setState(() {
      clickedKey = widget.key;
      widget.value = 'John';
    });
    print(widget.value);
    print('Working oooooooooooooo');
    print(clickedKey);
    if (clickedKey == widget.key) {
      setState(() {
        widget.color = Colors.white;
        widget.iconColor = Colors.greenAccent;
        textColor = Theme.of(context).colorScheme.primaryContainer;

        widget.value = 'kehinde';

        print('Workimmmmmmmmmmmmmmmmmmmmmmmm');
      });

      print(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: widget.key,
      onTap: _onSelectAnswer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: widget.color,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (!isMultiple)
                  CircleAvatar(
                    radius: 5.5,
                    backgroundColor:
                        widget.iconColor == null ? Colors.amber : null,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: widget.iconColor ?? Colors.white,
                    ),
                  ),
                if (isMultiple)
                  Container(
                    width: 15,
                    height: 15,
                    padding: const EdgeInsets.all(2.0),
                    color: widget.iconColor == null ? Colors.amber : null,
                    child: Container(
                      width: 10,
                      height: 10,
                      color: widget.iconColor ?? Colors.white,
                    ),
                  ),
                const SizedBox(width: 8),
                Text(
                  widget.answer ?? '',
                  style: TextStyle().copyWith(
                    color: textColor ??
                        Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
