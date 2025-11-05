import 'package:flutter_riverpod/flutter_riverpod.dart';

final currencyProvider = StateNotifierProvider<CurrencyNotifier, String>(
        (ref) => CurrencyNotifier());

class CurrencyNotifier extends StateNotifier<String>{
  CurrencyNotifier() : super('€'){
    loadCurrency();
  }

  void loadCurrency(){
    state = '€';
  }

  void reset(){
    state = '';
  }
}