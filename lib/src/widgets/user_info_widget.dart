import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final String title;
  final Function function;
  final int lines;

  UserInfoWidget(
      {@required this.title, @required this.function, this.lines = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(
            //   title,
            //   style: TextStyle(fontSize: 22),
            // ),
            SizedBox(
              height: 10,
            ),
            TextField(
              minLines: lines,
              maxLines: lines,
              onChanged: function,
              decoration: InputDecoration(
                hintText: title,
                hintStyle: TextStyle(color: Color(0xffC2C2C2)),
                contentPadding: EdgeInsets.all(8),
                isDense: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: Color(0xffC2C2C2))),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
