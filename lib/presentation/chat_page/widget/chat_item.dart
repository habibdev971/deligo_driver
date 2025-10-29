import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/build_network_image.dart';
import '../../../data/models/chatting_models/chat_message_model.dart';

Widget chatItem(BuildContext context, {ChatMessage? message, bool isMe = true}) => Row(
    mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      isMe ? const SizedBox.shrink() : CircleAvatar(
        backgroundColor: AppColors.primary,
        child: ClipOval(
          child: buildNetworkImage(
            imageUrl: message?.sender?.picture,
            height: 36.h,
            width: 36.w,
            fit: BoxFit.fill,
          ),
        ),
      ),
      Gap(isMe ? 0 : 12.w),
      Flexible(
        child: Container(
          padding: EdgeInsets.all(16.r),
          margin: EdgeInsets.only(bottom: 12.h),
          constraints: BoxConstraints(
            maxWidth: 220.w
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(16.r) : Radius.zero,
              topRight: isMe ? Radius.zero : Radius.circular(16.r),
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
            border: isMe ? Border.all(color: AppColors.primary) : null,
          ),
          child: Text(
            message?.message ?? '',
            style: context.bodyMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textTertiary,
            ),
          ),
        ),
      ),
    ],
  );
