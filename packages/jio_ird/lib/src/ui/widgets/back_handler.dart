import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackHandler extends StatelessWidget {
  final Widget child;
  final VoidCallback? onBack;

  const BackHandler({
    super.key,
    required this.child,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (!didPop) {
          if (onBack != null) {
            onBack!();
          } else {
            SystemNavigator.pop();
          }
        }
      },
      child: child,
    );
  }
}
