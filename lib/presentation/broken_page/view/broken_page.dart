import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/core/utils/exit_app_dialogue.dart';
import 'package:deligo_driver/core/widgets/buttons/app_primary_button.dart';
import 'package:deligo_driver/gen/assets.gen.dart';

class BrokenPage extends StatelessWidget {
  const BrokenPage({super.key});

  @override
  Widget build(BuildContext context) => ExitAppWrapper(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(height: 16.h, width: double.infinity, color: ColorPalette.neutralF6,),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r), bottom: Radius.circular(16.r))
                    ),
                    
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
      
                        Assets.images.broken.image(height: 200.h, width: 200.w),
                        Gap(24.h),
                        Text('Unexpected Application Crash', textAlign: TextAlign.center, style: context.bodyMedium?.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700, color: const Color(0xFF24262D)),),
                        Gap(8.h),
                        Text('The app encountered an unexpected error and had to close. This could be caused by insufficient device memory, a bug in the app, or a corrupted file. Please restart the app or reinstall it if the issue continues.', textAlign: TextAlign.center, style: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xFF464D5E)),),
                        Gap(24.h),
                        AppPrimaryButton(
                            backgroundColor: Colors.white,
      
                            onPressed: (){
      
                        }, child: Text('Contact Support', style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ColorPalette.primary50),))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
}
