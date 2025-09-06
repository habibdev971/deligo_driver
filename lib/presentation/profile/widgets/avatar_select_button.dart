import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:deligo_driver/core/utils/build_network_image.dart';

import '../../../../core/theme/color_palette.dart';
import '../../../gen/assets.gen.dart';
import 'select_profile_image_dialog.dart';

class AvatarSelectButton extends StatelessWidget {
  final String? avatarPath;
  const AvatarSelectButton({
    super.key,
    required this.avatarPath,
  });

  @override
  Widget build(BuildContext context) => Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 156.h,
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image: DecorationImage(
              image: Assets.images.profileInfoBackground.provider(),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Center(
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              showDialog(
                context: context,
                useSafeArea: false,
                builder: (context) => const SelectProfileImageDialog(),
              );
            }, minimumSize: const Size(0, 0),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 62.r,
                  backgroundColor: ColorPalette.primary50,
                  child: avatarPath != null
                      ? Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ClipOval(child: buildNetworkImage(imageUrl: avatarPath, height: 120.h, width: 120.w, fit: BoxFit.fill)),
                  )
                      : const SizedBox.shrink(),
                ),
                Positioned(
                  bottom: 4.r,
                  right: 4.r,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.primary50,
                    ),
                    padding: EdgeInsets.all(8.r),
                    child:  Icon(
                      Ionicons.camera,
                      color: Colors.white,
                      size: 18.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
}
