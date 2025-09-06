import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deligo_driver/presentation/booking/provider/ride_providers.dart';

import '../../../gen/assets.gen.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool _showLogo = false;

  @override
  void initState() {
    super.initState();
    _startSplashAnimation();

  }

  void _startSplashAnimation() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => _showLogo = true);
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Future.microtask(() {
        ref.read(tripActivityNotifierProvider.notifier).checkTripActivity();
      });
    });
  }


  @override
  Widget build(BuildContext context) => Scaffold(body: SafeArea(child: _buildAnimatedLogo()));

  Widget _buildAnimatedLogo() => AnimatedAlign(
      alignment: _showLogo ? Alignment.center : Alignment.bottomCenter,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      child: Assets.images.appLogo.image(
        height: 142,
        width: 192,
        fit: BoxFit.fill,
      ),
    );
}
