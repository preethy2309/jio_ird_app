library jio_ird;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/providers/external_providers.dart';
import 'package:jio_ird/jio_ird_app.dart';

import '../focus_theme.dart';

class JioIRDScreen extends StatelessWidget {
  final FocusTheme focusTheme;
  final String accessToken;
  final String serialNumber;
  final Map<String, dynamic> guestDetails;
  final Function(String event, dynamic data)? onSocketEvent;
  final String menuTitle;

  const JioIRDScreen({
    super.key,
    required this.focusTheme,
    required this.accessToken,
    required this.serialNumber,
    required this.guestDetails,
    this.onSocketEvent,
    this.menuTitle = "In Room Dining",
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        accessTokenProvider.overrideWithValue(accessToken),
        serialNumberProvider.overrideWithValue(serialNumber),
        guestDetailsProvider.overrideWithValue(guestDetails),
        socketEventProvider.overrideWithValue(onSocketEvent),
        menuTitleProvider.overrideWithValue(menuTitle),
        focusThemeProvider.overrideWithValue(focusTheme),
      ],
      child: const JioIRDApp(),
    );
  }
}
