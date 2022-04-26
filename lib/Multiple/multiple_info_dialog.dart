import 'package:flutter/material.dart';

import '../OverlappingBar/overlapping_dialog.dart';

/// Build an alert UI for Dialog.
class MultipleInfoDialog extends StatelessWidget {
  const MultipleInfoDialog({
    Key? key,
    this.content,
    this.titleWidget,
    this.elevation,
    this.actionsOverflowButtonSpacing,
    this.semanticLabel,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.titleTextStyle,
    this.contentTextStyle,
    this.actions,
    this.actionsPadding = EdgeInsets.zero,
    this.titlePadding,
    this.buttonPadding,
    this.actionsAlignment,
    this.actionsOverflowDirection,
    this.backgroundColor,
    this.clipBehavior = Clip.none,
    this.shape,
    this.alignment,
    this.rect,
    this.scrollable = false,
  })  : assert(contentPadding != null),
        super(key: key);

  final Widget? content;
  final Widget? titleWidget;
  final double? elevation;
  final double? actionsOverflowButtonSpacing;
  final String? semanticLabel;
  final TextStyle? titleTextStyle;
  final TextStyle? contentTextStyle;
  final List<Widget>? actions;
  final EdgeInsetsGeometry actionsPadding;
  final EdgeInsetsGeometry? titlePadding;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? buttonPadding;
  final MainAxisAlignment? actionsAlignment;
  final VerticalDirection? actionsOverflowDirection;
  final Color? backgroundColor;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final AlignmentGeometry? alignment;
  final Rect? rect;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    /// Used by many material design widgets to make sure that they are only used in contexts
    /// where they have access to localizations.
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);

    String? label = semanticLabel;
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        label ??= MaterialLocalizations.of(context).alertDialogLabel;
    }

    const double paddingScaleFactor = 0.0;
    final TextDirection? textDirection = Directionality.maybeOf(context);

    Widget? titleWidget;
    Widget? contentWidget;
    Widget? actionsWidget;

    /// Roundness calculation.
    if (titleWidget != null) {
      final EdgeInsets defaultTitlePadding =
          EdgeInsets.fromLTRB(24.0, 24.0, 24.0, content == null ? 20.0 : 0.0);
      final EdgeInsets effectiveTitlePadding =
          titlePadding?.resolve(textDirection) ?? defaultTitlePadding;
      titleWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveTitlePadding.left * paddingScaleFactor,
          right: effectiveTitlePadding.right * paddingScaleFactor,
          top: effectiveTitlePadding.top * paddingScaleFactor,
          bottom: effectiveTitlePadding.bottom,
        ),
        child: DefaultTextStyle(
          style: titleTextStyle ??
              dialogTheme.titleTextStyle ??
              theme.textTheme.headline6!,
          child: Semantics(
            namesRoute: label == null && theme.platform != TargetPlatform.iOS,
            container: true,
            child: titleWidget,
          ),
        ),
      );
    }

    /// Roundness calculation.
    if (content != null) {
      final EdgeInsets effectiveContentPadding =
          contentPadding?.resolve(textDirection) ?? EdgeInsets.zero;
      contentWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveContentPadding.left * paddingScaleFactor,
          right: effectiveContentPadding.right * paddingScaleFactor,
          top: titleWidget == null
              ? effectiveContentPadding.top * paddingScaleFactor
              : effectiveContentPadding.top,
          bottom: effectiveContentPadding.bottom,
        ),
        child: DefaultTextStyle(
          style: contentTextStyle ??
              dialogTheme.contentTextStyle ??
              theme.textTheme.subtitle1!,
          child: Semantics(
            container: true,
            child: content,
          ),
        ),
      );
    }

    if (actions != null) {
      final double spacing = (buttonPadding?.horizontal ?? 16) / 2;
      actionsWidget = Padding(
        padding: actionsPadding.add(EdgeInsets.all(spacing)),

        /// "overflow" the available horizontal space, in which case it lays
        child: OverflowBar(
          alignment: actionsAlignment ?? MainAxisAlignment.end,
          spacing: spacing,
          overflowAlignment: OverflowBarAlignment.end,
          overflowDirection: actionsOverflowDirection ?? VerticalDirection.down,
          overflowSpacing: actionsOverflowButtonSpacing ?? 0,
          children: actions!,
        ),
      );
    }

    List<Widget> columnChildren;
    if (scrollable) {
      columnChildren = <Widget>[
        if (titleWidget != null || content != null)
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (titleWidget != null) titleWidget,
                  if (content != null) contentWidget!,
                ],
              ),
            ),
          ),
        if (actions != null) actionsWidget!,
      ];
    } else {
      columnChildren = <Widget>[
        if (titleWidget != null) titleWidget,
        if (content != null) Flexible(child: contentWidget!),
        if (actions != null) actionsWidget!,
      ];
    }

    /// Creates a widget that sizes its child to the child's intrinsic width.
    Widget dialogChild = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columnChildren,
      ),
    );

    /// Use the semantics to execute a child's unique widget.
    if (label != null) {
      dialogChild = Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        namesRoute: true,
        label: label,
        child: dialogChild,
      );
    }

    /// Alert function to display on the graph.
    return OverlappingDialog(
      backgroundColor: backgroundColor,
      elevation: elevation,
      rect: rect,
      clipBehavior: clipBehavior,
      shape: shape,
      child: dialogChild,
    );
  }
}
