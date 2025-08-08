import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/focus_provider.dart';

class ProfileIcon extends ConsumerStatefulWidget {
  const ProfileIcon({super.key});

  @override
  ConsumerState<ProfileIcon> createState() => _ProfileIconState();
}

class _ProfileIconState extends ConsumerState<ProfileIcon> {
  bool profileFocused = false;

  @override
  Widget build(BuildContext context) {
    final profileFocusNode = ref.watch(profileFocusProvider);
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
