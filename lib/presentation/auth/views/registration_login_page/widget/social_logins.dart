
import 'package:deligo_driver/presentation/auth/views/registration_login_page/widget/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import 'or.dart';

Widget socialLogin(BuildContext context){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      or(context),
      Gap(20.h),
      socialButton(context, logo: Assets.images.gmail, title: AppLocalizations.of(context).signup_with_gmail, onTap: (){}),
      // socialButton(context, logo: Assets.images.facebook, title: AppLocalizations.of(context).signup_with_facebook, onTap: (){}),
      // socialButton(context, logo: Assets.images.apple, title: AppLocalizations.of(context).signup_with_apple, onTap: (){}),
    ],
  );
}