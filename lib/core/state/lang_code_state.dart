import '../../data/models/country_code.dart';
import 'package:equatable/equatable.dart';

class LangCodeState extends Equatable {
  final CountryCode? selectedCode;
  final CountryCode? selectedLang;

  const LangCodeState({
     this.selectedCode,
     this.selectedLang,
  });

  factory LangCodeState.empty() => const LangCodeState();

  LangCodeState copyWith({
    CountryCode? selectedCode,
    CountryCode? selectedLang,
  }) => LangCodeState(
    selectedCode: selectedCode ?? this.selectedCode,
    selectedLang: selectedLang ?? this.selectedLang,
  );

  @override
  List<Object?> get props => [selectedCode, selectedLang];

  @override
  String toString() =>
      'LangCodeState(selectedCode: $selectedCode, selectedLang: $selectedLang)';
}