import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Brendow"),
              Text("Rua X, N12")
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Preço Produtos", style: TextStyle(fontWeight: FontWeight.w500),),
            Text("Preço total")
          ],
        )
      ],
    );
  }
}
