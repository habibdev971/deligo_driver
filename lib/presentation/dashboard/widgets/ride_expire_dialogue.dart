import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:flutter/material.dart';

Future<void> showAutoCloseDialog(BuildContext context, {required String timeDifference}) async {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, _, _) => const SizedBox.shrink(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final scale = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
      );

      return Transform.scale(
        scale: scale.value,
        child: Opacity(
          opacity: animation.value,
          child: RideExpireDialog(timeDifference: timeDifference,),
        ),
      );
    },
  );

  /// Auto close after 3 seconds
  await Future.delayed(const Duration(seconds: 3));
  Navigator.of(context).pop();
}

class RideExpireDialog extends StatelessWidget {
  final String timeDifference;
  const RideExpireDialog({super.key, required this.timeDifference});

  @override
  Widget build(BuildContext context) => Center(
      child: Material(
        color: isDarkMode() ? Colors.black : Colors.white,
        elevation: 12,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDarkMode() ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.timer_off,
                color: Colors.redAccent,
                size: 40,
              ),
              const SizedBox(height: 12),

              Text(
                'Ride Accept Time Expired',
                textAlign: TextAlign.center,
                style: context.bodyMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'You did not accept the ride request within the allowed time.',
                textAlign: TextAlign.center,
                style: context.bodyMedium?.copyWith(fontSize: 14),
              ),

              const SizedBox(height: 14),

              Text(
                'Expired after: 2 min 30 seconds',
                style: context.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),
              Text(
                'Request was send $timeDifference ago',
                style: context.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
}
