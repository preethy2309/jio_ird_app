import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/token_storage_service.dart';

final tokenStorageProvider = Provider<TokenStorageService>((ref) {
  return TokenStorageService();
});
