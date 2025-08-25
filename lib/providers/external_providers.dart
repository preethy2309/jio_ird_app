import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../focus_theme.dart';

final accessTokenProvider =
    Provider<String>((ref) => throw UnimplementedError());
final serialNumberProvider =
    Provider<String>((ref) => throw UnimplementedError());
final guestDetailsProvider = Provider<Map<String, dynamic>>((ref) => {});
final socketEventProvider = Provider<Function(String, dynamic)?>((ref) => null);
final menuTitleProvider = Provider<String>((ref) => "In Room Dining");

final focusThemeProvider = Provider<FocusTheme>((ref) {
  throw UnimplementedError('FocusTheme must be overridden in JioIRDScreen');
});
