import 'package:flutter/material.dart';
import '../models/faq_model.dart';

class FaqWidget extends StatefulWidget {
  final String title;
  final String description;
  bool isOpened;

  FaqWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.isOpened});

  @override
  State<FaqWidget> createState() => _FaqWidgetState();
}

class _FaqWidgetState extends State<FaqWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.only(top: 10),
        child: Column(children: [
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              child: ListTile(
                tileColor: Colors.grey[200],
                title: Text(widget.title),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                trailing: Icon(
                    widget.isOpened
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 30,
                    color: Colors.black),
                onTap: () => setState(() {
                  widget.isOpened = !widget.isOpened;
                }),
              )),
          Visibility(
              visible: widget.isOpened,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  margin: const EdgeInsets.only(top: 5),
                  child: Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      child: Container(
                          margin: EdgeInsets.all(20),
                          child: Text(widget.description)))))
        ]));
  }
}
