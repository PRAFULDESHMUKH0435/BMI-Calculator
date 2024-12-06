import 'package:flutter/widgets.dart';
class Routes{
static Route createRoute(Widget screenname) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screenname,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Start from the right
      const end = Offset.zero; // Move to the center
      const curve = Curves.easeIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
}