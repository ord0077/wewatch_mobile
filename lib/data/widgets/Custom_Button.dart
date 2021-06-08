import 'package:flutter/material.dart';
import 'package:wewatchapp/consts.dart';

class BouncingButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPress;

  BouncingButton({@required this.child, Key key, this.onPress})
      : assert(child != null),
        super(key: key);

  @override
  _BouncingState createState() => _BouncingState();
}

class _BouncingState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        if (widget.onPress != null) {
          _controller.forward();
        }
      },
      onPointerUp: (PointerUpEvent event) {
        if (widget.onPress != null) {
          _controller.reverse();
          widget.onPress();
        }
      },
      child: Transform.scale(
          scale: _scale,
          child:  Container(

            margin: EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x80000000),
                    blurRadius: 15.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
                color: DarkBlue,
              //   gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   colors: [
              //     Color(0xFF0000FF),
              //     Color(0xFFFF3500),
              //   ],
              // )

            ),
            child: Center(
                child: Text('Submit',textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0,color: Colors.white,fontWeight: FontWeight.w500))
            ),
          )
      ),
    );
  }
}
