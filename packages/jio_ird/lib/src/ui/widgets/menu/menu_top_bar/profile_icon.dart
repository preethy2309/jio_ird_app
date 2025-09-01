import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../providers/external_providers.dart';

class ProfileIcon extends ConsumerStatefulWidget {
  const ProfileIcon({super.key});

  @override
  ConsumerState<ProfileIcon> createState() => _ProfileIconState();
}

class _ProfileIconState extends ConsumerState<ProfileIcon> {
  @override
  Widget build(BuildContext context) {
    final logo = ref.watch(resolvedHotelLogoProvider);

    return InkWell(
      onTap: _goToProfile,
      child: ClipOval(
        child: logo != null
            ? Image(
                image: logo,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded || frame != null) {
                    return child;
                  }
                  return _buildShimmer();
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/hotel_logo.png',
                    package: 'jio_ird',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  );
                },
              )
            : Image.asset(
                'assets/images/hotel_logo.png',
                package: 'jio_ird',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 60,
        height: 60,
        color: Colors.white,
      ),
    );
  }

  void _goToProfile() {
    debugPrint('Profile pressed');
  }
}
