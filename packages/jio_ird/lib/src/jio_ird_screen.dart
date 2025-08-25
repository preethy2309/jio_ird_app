library jio_ird;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/src/data/models/guest_info.dart';
import 'package:jio_ird/src/providers/external_providers.dart';

import 'focus_theme.dart';
import 'jio_ird_app.dart';

class JioIRDScreen extends StatelessWidget {
  final FocusTheme focusTheme;
  final String accessToken;
  final String serialNumber;
  final GuestInfo guestInfo;
  final String menuTitle;
  final Function(String event, dynamic data)? onSocketEvent;

  const JioIRDScreen({
    super.key,
    required this.focusTheme,
    required this.accessToken,
    required this.serialNumber,
    required this.guestInfo,
    this.onSocketEvent,
    this.menuTitle = "In Room Dining",
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        accessTokenProvider.overrideWithValue(accessToken),
        serialNumberProvider.overrideWithValue(serialNumber),
        guestDetailsProvider.overrideWithValue(guestInfo),
        socketEventProvider.overrideWithValue(onSocketEvent),
        menuTitleProvider.overrideWithValue(menuTitle),
        focusThemeProvider.overrideWithValue(focusTheme),
      ],
      child: const JioIRDApp(),
    );
  }
}
