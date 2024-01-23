import 'dart:async';

import 'package:flutter/material.dart';
import 'package:packmen_app/screens/auth/storage/user_storage.dart';
import 'package:packmen_app/screens/introduction_animation/components/second_view.dart';
import 'package:packmen_app/screens/introduction_animation/components/center_next_button.dart';
import 'package:packmen_app/screens/introduction_animation/components/third_view.dart';
import 'package:packmen_app/screens/introduction_animation/components/first_view.dart';
import 'package:packmen_app/screens/introduction_animation/components/splash_view.dart';
import 'package:packmen_app/screens/introduction_animation/components/top_back_skip_view.dart';
import 'package:packmen_app/screens/introduction_animation/components/welcome_view.dart';
import 'package:packmen_app/core/app_export.dart';

class IntroductionAnimationScreen extends StatefulWidget {
  const IntroductionAnimationScreen({Key? key}) : super(key: key);

  @override
  _IntroductionAnimationScreenState createState() =>
      _IntroductionAnimationScreenState();
}

class _IntroductionAnimationScreenState
    extends State<IntroductionAnimationScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animationController?.animateTo(0.0);
    Timer(const Duration(milliseconds: 1000), () {
      final token = UserStorage.getToken() ?? '';
      if (token != '') {
        Get.offAllNamed(AppRoutes.homeScreen);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HexColor('#D0AD5E'),
      backgroundColor: HexColor('#f5f5f4'),
      body: ClipRect(
        child: Stack(
          children: [
            SplashView(
              animationController: _animationController!,
            ),
            FirstView(
              animationController: _animationController!,
            ),
            SecondView(
              animationController: _animationController!,
            ),
            ThirdView(
              animationController: _animationController!,
            ),
            WelcomeView(
              animationController: _animationController!,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController!,
            ),
            CenterNextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    Get.toNamed(AppRoutes.registerScreen);
  }
}
