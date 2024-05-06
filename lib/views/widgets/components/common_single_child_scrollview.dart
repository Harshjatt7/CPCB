import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CommonSingleChildScrollView extends StatelessWidget {
  /// Creates a box in which a single widget can be scrolled.
  const CommonSingleChildScrollView({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.child,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  }) : assert(
          !(controller != null && (primary ?? false)),
          'Primary ScrollViews obtain their ScrollController via inheritance '
          'from a PrimaryScrollController widget. You cannot both set primary to '
          'true and pass an explicit controller.',
        );

  final Axis scrollDirection;

  final bool reverse;

  final EdgeInsetsGeometry? padding;

  final ScrollController? controller;

  final bool? primary;

  final ScrollPhysics? physics;

  final Widget? child;

  final DragStartBehavior dragStartBehavior;

  final Clip clipBehavior;

  final String? restorationId;

  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  final initialPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: SingleChildScrollView(
        key: key,
        clipBehavior: clipBehavior,
        controller: controller,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        padding: padding,
        physics: physics,
        primary: primary,
        restorationId: restorationId,
        reverse: reverse,
        scrollDirection: scrollDirection,
        child: child,
      ),
    );
  }
}
