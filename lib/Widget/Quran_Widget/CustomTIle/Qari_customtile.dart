
import 'package:flutter/material.dart';

import '../../../Constant/color.dart';
import '../../../Module/Quran/Qari.dart';


class QariCustomTile extends StatefulWidget {

  final Qari qari;
  final VoidCallback ontap;

  const QariCustomTile({
    Key? key,
    required this.qari,
    required this.ontap
  }) : super(key: key);

  @override
  State<QariCustomTile> createState() => _QariCustomTileState();
}

class _QariCustomTileState extends State<QariCustomTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 0,
                color: hexStringToColor("03045E"),
                offset: Offset(0,1)
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.qari.name!, textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: hexStringToColor("03045E")),)
            ],
          ),
        ),
      ),
    );
  }
}
