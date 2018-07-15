import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TouchySticker extends StatefulWidget {
  final String imageAssetPath;
  final Function onTap;

  const TouchySticker({
    Key key,
    @required this.imageAssetPath,
    this.onTap,
  }) : super(key: key);

  @override
  TouchyStickerState createState() {
    return new TouchyStickerState();
  }
}

class TouchyStickerState extends State<TouchySticker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            widget.imageAssetPath,
          ),
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
