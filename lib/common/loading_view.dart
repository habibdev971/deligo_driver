import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/assets.gen.dart';

class LoadingView extends StatelessWidget {
  final String? message;
  final Widget? loadingWidget;
  const LoadingView({
    super.key,
    this.message,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          loadingWidget ?? Assets.lottie.loading.lottie(height: 120.h, width: 120.w, fit: BoxFit.fill),
          if (message != null)
            Padding(
              padding: EdgeInsets.only(top: 16.0.r),
              child: Text(
                message!,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            )
        ],
      ),
    );
}
