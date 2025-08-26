import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/src/data/models/guest_info.dart';

import '../focus_theme.dart';
import '../ui/widgets/menu/bottom_layout.dart';

final baseUrlProvider = Provider<String>((ref) => throw UnimplementedError());

final accessTokenProvider =
    Provider<String>((ref) => throw UnimplementedError());

final serialNumberProvider =
    Provider<String>((ref) => throw UnimplementedError());

final guestDetailsProvider =
    Provider<GuestInfo>((ref) => throw UnimplementedError());

final socketEventProvider = Provider<Function(String, dynamic)?>((ref) => null);

final menuTitleProvider = Provider<String>((ref) => "In Room Dining");

final focusThemeProvider = Provider<FocusTheme>((ref) {
  throw UnimplementedError('FocusTheme must be overridden in JioIRDScreen');
});

final bottomBarProvider = Provider<Widget?>((ref) {
  return const BottomLayout();
});
