import 'package:flutter/cupertino.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';

import '../../data/models/country_code.dart';
import 'buttons/app_radio_button.dart';

class AppCountryCodeListItem extends StatelessWidget {
  final CountryCode countryCode;
  final Function(CountryCode countryCode) onPressed;
  final bool isSelected;
  final bool selectCountryCode;

  const AppCountryCodeListItem({
    super.key,
    required this.countryCode,
    required this.onPressed,
    required this.isSelected, required this.selectCountryCode,
  });

  @override
  Widget build(BuildContext context) => CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              countryCode.flag,
              width: 24,
              height: 24,
              filterQuality: FilterQuality.high,
              isAntiAlias: true,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              countryCode.name,
              style: context.labelLarge,
            ),
          ),
          selectCountryCode ? Text(
            countryCode.phoneCode,
            style: context.labelSmall,
          ) : const SizedBox.shrink(),
          const SizedBox(
            width: 12,
          ),
          AppRadioButton(
            groupValue: isSelected,
            value: true,
            onChanged: (value) => onPressed(countryCode),
          ),
        ],
      ),
      onPressed: () => onPressed(countryCode),
    );
}