import 'package:flutter/material.dart';
import 'dart:async';

class StartTravelInput extends StatefulWidget {
  const StartTravelInput({Key? key, this.hint = "Where are you going?", this.onPressed, this.focused = false, this.onInput}) : super(key: key);

  final String hint;
  final VoidCallback? onPressed;
  final Function(String)? onInput;
  final bool focused;

  @override
  State<StartTravelInput> createState() => _StartTravelInputState();
}

class _StartTravelInputState extends State<StartTravelInput> {
  final TextEditingController _controller = TextEditingController();
  final focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => Future.delayed(Duration(milliseconds: 200), () {
      if (focusNode.hasFocus) return;
      focusNode.requestFocus();
    }));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
        if (widget.onInput != null) {
          widget.onInput!(_controller.text);
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          // color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: TextField(
                focusNode: focusNode,
                enabled: widget.onPressed == null,
                controller: _controller,
                onChanged: _onSearchChanged,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black                  
                ),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: widget.hint,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(238, 127, 0, 0.8),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
              ),
              margin: EdgeInsets.only(left: 12, right: 12),
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Average waiting time: 3min", style: TextStyle(color: Colors.white60))
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
