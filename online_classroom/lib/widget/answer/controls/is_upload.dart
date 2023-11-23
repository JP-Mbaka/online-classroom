import 'package:flutter/material.dart';
import 'package:online_classroom/constants/dimensions.dart';
import 'package:online_classroom/model/task/question_model.dart';
import 'package:online_classroom/widget/base.dart';


// ignore: must_be_immutable
class IsUpload extends StatefulWidget {
  Question? question;
  int questNo;

  IsUpload({super.key, this.question, required this.questNo});

  @override
  State<IsUpload> createState() => _IsUploadState();
}

class _IsUploadState extends State<IsUpload> {
  @override
  Widget build(BuildContext context) {
    print(widget.questNo);
    return SizedBox(
      width: double.infinity,
      child: Column(children: [
        SizedBox(
          width: double.infinity,
          child: questionCard(context,
              questNo: widget.questNo,
              question: widget.question!.question,
              color: Theme.of(context).colorScheme.onBackground),
        ),
        SizedBox(height: height(context) * 0.02),
        ElevatedButton(onPressed: () {}, child: Text('Upload your file')),
      ]),
    );
  }
}
