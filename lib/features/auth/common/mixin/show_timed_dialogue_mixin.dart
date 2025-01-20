import 'package:flutter/material.dart';

mixin ShowTimerDialogueMixin<T extends StatefulWidget> on State<T> {
  void showTimedDialog(BuildContext context, String text) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: -50,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: -50.0, end: 100.0),
          duration: Duration(seconds: 1),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, value),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF145F48),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 10), () {
      overlayEntry.remove();
    });
  }
}
