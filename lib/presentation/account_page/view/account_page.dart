import 'package:deligo_driver/core/utils/build_network_image.dart';
import 'package:deligo_driver/data/models/ride_data_model/Driver.dart';
import 'package:deligo_driver/data/services/url_launch_services.dart';
import 'package:deligo_driver/presentation/account_page/widgets/language_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/common/shimmer_loader.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/core/utils/delete_account_dialogue.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:deligo_driver/presentation/profile/provider/profile_providers.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/exit_app_dialogue.dart';
import '../../../data/models/user_model/user_model.dart';
import '../../../gen/assets.gen.dart';
import '../provider/theme_provider.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(driverDetailsNotifierProvider.notifier).getDriverDetails();
      ref.read(rideDataCountProvider.notifier).getRideData();
    });
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      backgroundColor: isDarkMode() ? Colors.black : Colors.white,
      body: Column(
        children: [
          Container(
            height: 8.h,
            width: double.infinity,
            color: isDarkMode() ? Colors.black12 : const Color(0xFFF6F7F9),
          ),
          userDetails(context),
          Gap(8.h),
          accountDetails(context, ref: ref),
        ],
      ),
    ),
  );
}

Widget userDetails(BuildContext context) => Padding(
  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
  child: Column(
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),

          // image: DecorationImage(
          //   image: Assets.images.walletBackground.provider(),
          //   fit: BoxFit.fill,
          // ),
        ),
        child: Consumer(
          builder: (context, ref, _) {
            final driverDetails = ref
                .watch(driverDetailsNotifierProvider)
                .mapOrNull(
                  success: (data) => data.data.data,
                  error: (error) => null,
                );
            final rideData = ref.watch(rideDataCountProvider).whenOrNull(success: (v)=> v);

            final bool isLoading =
                (ref
                    .watch(driverDetailsNotifierProvider)
                    .whenOrNull(loading: () => true) ??
                false) || (ref.watch(rideDataCountProvider).whenOrNull(loading: ()=> true) ?? false);

            return isLoading
                ? buildShimmer(
                    height: 160,
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(16.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 33.r,
                          backgroundColor: Colors.white,
                        ),
                        Gap(8.h),
                        const SizedBox(width: double.infinity),
                        const Text(
                          'Name',
                          style: TextStyle(color: Colors.white),
                        ),
                        const Text(
                          'Phone',
                          style: TextStyle(color: Colors.white),
                        ),
                        Gap(8.h),
                        Row(
                          children: List.generate(
                            3,
                            (index) => Expanded(
                              child: Container(
                                height: 48.h,
                                margin: index != 2
                                    ? EdgeInsets.only(right: 16.w)
                                    : null,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      CircleAvatar(
                        radius: 33.r,
                        backgroundColor: Colors.white,
                        child: driverDetails?.userInfo?.fullPictureUrl != null
                            ? Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ClipOval(
                                  child: buildNetworkImage(imageUrl: driverDetails!.userInfo!.fullPictureUrl!, height: 60.h, width: 60.w, fit: BoxFit.fill)
                                  // child: CachedNetworkImage(
                                  //   imageUrl: driverDetails!.profilePicture!,
                                  //   height: 60.h,
                                  //   width: 60.w,
                                  //   fit: BoxFit.fill,
                                  // ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      Gap(8.h),
                      Text(
                        driverDetails?.fullName ?? 'N/A',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.bodyMedium?.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          // color: Colors.white,
                        ),
                      ),
                      Gap(4.h),
                      Text(
                        driverDetails?.phoneNumber ?? 'N/A',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          // color: Colors.white60,
                        ),
                      ),
                      Gap(16.h),
                      driverRideStory(context, rideData),
                    ],
                  );
          },
        ),
      ),
    ],
  ),
);

Widget driverRideStory(BuildContext context, RideDataCount? rideData) => Row(
  children: [
    rideStory(
      context,
      // logo: Assets.images.taxiCab,
      title: localize(context).total_rides,
      amount: (rideData?.rideCount ?? 0).toString(),
    ),
    Gap(8.w),
    rideStory(
      context,
      // logo: Assets.images.distanceLogo,
      title: localize(context).total_distance,
      amount: '${rideData?.totalDistance ?? 0} KM',
    ),
    // Gap(8.w),
    // rideStory(
    //   context,
    //   // logo: Assets.images.star,
    //   title: localize(context).average_rating,
    //   amountWidget: RichText(
    //     maxLines: 1,
    //     overflow: TextOverflow.ellipsis,
    //     text: TextSpan(
    //       text: (driverDetail?.rating ?? 0).toString(),
    //       style: context.bodyMedium?.copyWith(
    //         fontSize: 14.sp,
    //         fontWeight: FontWeight.w600,
    //         color: isDarkMode() ? Colors.white54 : const Color(0xFF24262D),
    //       ),
    //       children: [
    //         TextSpan(
    //           text: '(${driverDetail?.reviewCount ?? 0})',
    //           style: context.bodyMedium?.copyWith(
    //             fontSize: 10.sp,
    //             fontWeight: FontWeight.w400,
    //             color: const Color(0xFF687387),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // ),
  ],
);

Widget rideStory(
  BuildContext context, {
  String? amount,
  Widget? amountWidget,
  // required AssetGenImage logo,
  required String title,
}) => Expanded(
  child: Container(
    padding: EdgeInsets.all(8.r),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      color: isDarkMode() ? Colors.black : Colors.white,
      border: Border.all(color: ColorPalette.primary50),
    ),
    child: Column(
      children: [
        amountWidget ??
            Text(
              amount ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode()
                    ? Colors.white54
                    : const Color(0xFF24262D),
              ),
            ),
        Gap(4.h),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.bodyMedium?.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: isDarkMode() ? Colors.white54 : const Color(0xFF24262D),
          ),
        ),
      ],
    ),
  ),
);

Widget accountDetails(
  BuildContext context, {
  required WidgetRef ref,
}) => Expanded(
  child: SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
      child: Column(
        children: [
          accountButton(
            context,
            leading: Assets.images.myProfile.image(
              height: 24.h,
              width: 24.w,
              fit: BoxFit.fill,
            ),
            title: localize(context).my_profile,
            onTap: () {
              NavigationService.pushNamed(AppRoutes.profileInfoPage);
            },
          ),
          Gap(8.h),
          accountButton(
            context,
            leading: Assets.images.payout.image(
              height: 24.h,
              width: 24.w,
              fit: BoxFit.fill,
            ),
            title: localize(context).payout_method,
            onTap: () {
              NavigationService.pushNamed(AppRoutes.payoutMethod);
            },
          ),
          Gap(8.h),
          accountButton(
            context,
            leading: Assets.images.language.image(
              height: 24.h,
              width: 24.w,
              fit: BoxFit.fill,
              // color: ColorPalette.primary50
            ),
            title: localize(context).language,
            trailing: countrySelector(loadAddress: true),
          ),
          Gap(8.h),
          accountButton(
            context,
            leading: Assets.images.theme.image(
              height: 24.h,
              width: 24.w,
              fit: BoxFit.fill,
            ),
            title: localize(context).theme,
            trailing: const ThemeSwitchTile(),
          ),
          Gap(8.h),
          // accountButton(
          //   context,
          //   leading: Assets.images.changePassword.image(
          //     height: 24.h,
          //     width: 24.w,
          //     fit: BoxFit.fill,
          //   ),
          //   title: localize(context).change_password,
          //   onTap: () => NavigationService.pushNamed(AppRoutes.changePassword),
          // ),
          // Gap(8.h),
          accountButton(
            context,
            leading: Assets.images.terms.image(
              height: 24.h,
              width: 24.w,
              fit: BoxFit.fill,
            ),
            title: localize(context).terms_conditions,
            onTap: () {
              UrlLaunchServices.launchUrls('https://deligoeu.com/term.html');
              // ref.read(termsAndConditionProvider.notifier).termsAndCondition();
              // termsAndConditionDialogue(context);
            },
          ),
          Gap(8.h),
          accountButton(
            context,
            leading: Assets.images.privacy.image(
              height: 24.h,
              width: 24.w,
              fit: BoxFit.fill,
            ),
            title: localize(context).privacy_policy,
            onTap: () {
              UrlLaunchServices.launchUrls('https://deligoeu.com/term.html');
              // ref.read(privacyAndPolicyProvider.notifier).privacyPolicy();
              // termsAndConditionDialogue(context, showTermsAndCondition: false);
            },
          ),
          Gap(8.h),
          Consumer(
            builder: (context, ref, _) => accountButton(
              context,
              leading: Assets.images.logOut.image(
                height: 24.h,
                width: 24.w,
                fit: BoxFit.fill,
              ),
              title: localize(context).log_out,
              onTap: () {
                showExitLogoutDialogue(ref: ref, isLogout: true);
              },
            ),
          ),
          Gap(8.h),
          accountButton(
            context,
            leading: Assets.images.trash.image(
              height: 24.h,
              width: 24.w,
              fit: BoxFit.fill,
            ),
            title: localize(context).delete_account,
            onTap: () {
              showDeleteAccountDialog();
            },
          ),
        ],
      ),
    ),
  ),
);

Widget accountButton(
  BuildContext context, {
  Function()? onTap,
  Widget? leading,
  required String title,
  Widget? trailing,
}) => InkWell(
  onTap: onTap,
  child: Container(
    constraints: BoxConstraints(minHeight: 48.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      color: isDarkMode() ? Colors.black : const Color(0xFFF6F7F9),
      border: isDarkMode() ? Border.all(color: Colors.white) : null,
    ),
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    // margin: EdgeInsets.only(bottom: 8.h),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 16.0.w),
          child: leading ?? const SizedBox.shrink(),
        ),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.bodyMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isDarkMode() ? Colors.white : const Color(0xFF363A44),
            ),
          ),
        ),
        trailing ?? const SizedBox.shrink(),
      ],
    ),
  ),
);

class ThemeSwitchTile extends ConsumerStatefulWidget {
  const ThemeSwitchTile({super.key});

  @override
  ConsumerState<ThemeSwitchTile> createState() => _ThemeSwitchTileState();
}

class _ThemeSwitchTileState extends ConsumerState<ThemeSwitchTile> {
  late bool isDark;

  @override
  void initState() {
    super.initState();
    isDark = isDarkMode();
  }

  void _toggleTheme() {
    setState(() {
      isDark = !isDark;
    });

    ref
        .read(themeModeProvider.notifier)
        .setTheme(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: isDark ? Colors.black12 : const Color(0xFFF6F7F9),
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: GestureDetector(
      onTap: _toggleTheme,
      child: Container(
        width: 54.w,
        height: 24.h,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: isDark ? Colors.black12 : const Color(0xFFEDEEF0),
          border: isDark ? Border.all(color: Colors.white) : null,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 22.r,
            height: 22.r,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                size: 16.sp,
                color: ColorPalette.primary50,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget countrySelector({
  bool showDecoration = false,
  bool loadAddress = false,

}) => buildLanguagePickerButton();
