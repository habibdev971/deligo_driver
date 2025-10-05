import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/country_code_notifier.dart';

final selectedPhoneCodeProvider =
StateNotifierProvider<SelectedPhoneCodeNotifier, String>(
      (ref) => SelectedPhoneCodeNotifier(),
);
