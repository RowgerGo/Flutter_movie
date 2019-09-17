import 'package:flutter/material.dart';

class ListRow extends StatefulWidget {
  final String title;
  final String icon;
  final void Function() handlerClick;

  const ListRow({Key key,this.title,this.icon,this.handlerClick}):super(key:key);

  @override
  _ListRowState createState() => _ListRowState();
}

class _ListRowState extends State<ListRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
    child: Row(
      children: <Widget>[
        FlatButton(
            onPressed: (){
              widget.handlerClick();
            },
            child: Container(
              child: Row(
                children: <Widget>[
                  Text(widget.title),
                  Text(widget.title),
                  Text(widget.title),
                ],
              ),
            )
        )
      ],
    ),
    );
  }
}

