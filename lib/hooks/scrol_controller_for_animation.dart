import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

ScrollController useScrollControllerForAnimation(
    AnimationController controller) {
  return use(_ScrollControllerForAnimationHook(controller: controller));
}

class _ScrollControllerForAnimationHook extends Hook<ScrollController> {
  final AnimationController controller;
  const _ScrollControllerForAnimationHook({
    @required this.controller,
  });
  @override
  _ScrollControllerForAnimationHookState createState() =>
      _ScrollControllerForAnimationHookState();
}

class _ScrollControllerForAnimationHookState
    extends HookState<ScrollController, _ScrollControllerForAnimationHook> {
  ScrollController _scrollController;
  @override
  void initHook() {
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        // Scrolling up - forward the animation (value goes to 1)
        case ScrollDirection.forward:
          hook.controller.forward();
          break;
        // Scrolling down - reverse the animation (value goes to 0)
        case ScrollDirection.reverse:
          hook.controller.reverse();
          break;
        // Idle - keep FAB visibility unchanged
        case ScrollDirection.idle:
          break;
      }
    });
  }

  @override
  ScrollController build(BuildContext context) => _scrollController;
  @override
  void dispose() => _scrollController.dispose();
}
