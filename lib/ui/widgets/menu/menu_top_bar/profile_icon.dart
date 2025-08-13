import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileIcon extends ConsumerStatefulWidget {
  const ProfileIcon({super.key});

  @override
  ConsumerState<ProfileIcon> createState() => _ProfileIconState();
}

class _ProfileIconState extends ConsumerState<ProfileIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _goToProfile,
      child: Image.asset(
        'assets/images/hotel_logo.png',
        width: 100,
        height: 60,
        fit: BoxFit.cover,
      ),
    );
  }

  void _goToProfile() {
    debugPrint('Profile pressed');
    // Navigate to profile
  }
}
