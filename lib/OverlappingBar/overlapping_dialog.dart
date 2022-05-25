import 'package:flutter/material.dart';

/// Alert function to display on the graph.
class OverlappingDialog extends StatelessWidget {
  const OverlappingDialog({
    Key? key,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.clipBehavior = Clip.none,
    this.shape,
    this.rect,
    this.child,
  }) : super(key: key);
  final Color? backgroundColor;
  final double? elevation;
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final Rect? rect;
  final Widget? child;

  ///　default function of shape.
  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(0)),
  );
  static const double _defaultElevation = 0;

  @override
  Widget build(BuildContext context) {
    /// Define dialog widget theme
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return AnimatedPadding(
      padding: EdgeInsets.zero,
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,

      /// Removes the specified view inset, however, from the specified context.
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Stack(
          children: [
            Positioned(
              top: rect?.top ?? 0.0,
              left: rect?.left ?? 0.0,
              width: rect?.width ?? 0.0,
              height: rect?.height ?? 0.0,

              /// Class Material extends StatefulWidget Create a material.
              child: Material(
                color: backgroundColor ??
                    dialogTheme.backgroundColor ??
                    Theme.of(context).dialogBackgroundColor,
                elevation:
                    elevation ?? dialogTheme.elevation ?? _defaultElevation,
                shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
                type: MaterialType.card,
                clipBehavior: clipBehavior,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
