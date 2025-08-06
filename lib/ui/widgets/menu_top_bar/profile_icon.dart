import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileIcon extends StatefulWidget {
  const ProfileIcon({super.key});

  @override
  State<ProfileIcon> createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  final FocusNode profileFocusNode = FocusNode();
  bool profileFocused = false;

  @override
  void dispose() {
    profileFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: profileFocusNode,
      onFocusChange: (hasFocus) => setState(() => profileFocused = hasFocus),
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.select ||
            event.logicalKey == LogicalKeyboardKey.enter) {
          _goToProfile();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        onTap: _goToProfile,
        child: Container(
          decoration: BoxDecoration(
            color: profileFocused ? Colors.amber : Colors.white12,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(6),
          child: const Icon(Icons.person, color: Colors.white, size: 40),
        ),
      ),
    );
  }

  void _goToProfile() {
    debugPrint('Profile pressed');
    // Navigate to profile
  }
}
