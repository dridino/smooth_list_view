library smooth_list_view;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math' as math;
import 'dart:io' show Platform;

/// Implements a smooth version of `ListView`, mainly for desktop usage.
///
/// The constructor matches the `ListView`'s one, with the exact same parameters
/// except for `curve` and `duration`, used to customize the animation.
class SmoothListView extends StatelessWidget {
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final List<Widget> children;
  final Clip clipBehavior;
  final ScrollController? controller;
  final Curve curve;
  final DragStartBehavior dragStartBehavior;
  final Duration duration;
  final bool enableKeyScrolling;
  final double? itemExtent;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool? primary;
  final Widget? prototypeItem;
  final String? restorationId;
  final bool reverse;
  final Axis scrollDirection;
  final int? semanticChildCount;
  final bool shouldScroll;
  final bool shrinkWrap;

  const SmoothListView({
    Key? key,
    required this.children,
    required this.duration,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.clipBehavior = Clip.hardEdge,
    this.curve = Curves.easeOut,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableKeyScrolling = true,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.shouldScroll = true,
    this.shrinkWrap = false,
    this.cacheExtent,
    this.controller,
    this.itemExtent,
    this.padding,
    this.physics,
    this.primary,
    this.prototypeItem,
    this.restorationId,
    this.semanticChildCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SmoothListViewItems(
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
      controller: controller ?? ScrollController(),
      curve: curve,
      dragStartBehavior: dragStartBehavior,
      duration: duration,
      enableKeyScrolling: enableKeyScrolling,
      itemExtent: itemExtent,
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      physics: physics,
      primary: primary,
      prototypeItem: prototypeItem,
      restorationId: restorationId,
      reverse: reverse,
      scrollDirection: scrollDirection,
      semanticChildCount: semanticChildCount,
      shouldScroll: shouldScroll,
      shrinkWrap: shrinkWrap,
      smoothScroll: true,
      children: children,
    );
  }

  /// Implements a smooth version of `ListView.builder()`, mainly for desktop
  /// usage.
  ///
  /// The constructor matches the `ListView.builder()`'s one, with the exact
  /// same parameters, except for `curve` and `duration` used to customize
  /// the animation, `enableKeyScrolling` to enable scroll while pressing
  /// arrow keys and `shouldScroll` used to decide wether this `ListView`
  /// should be scrollale or not.
  static Widget builder({
    Key? key,
    required Duration duration,
    required IndexedWidgetBuilder itemBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    Clip clipBehavior = Clip.hardEdge,
    Curve curve = Curves.easeOut,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool enableKeyScrolling = true,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    bool reverse = false,
    Axis scrollDirection = Axis.vertical,
    bool shouldScroll = true,
    bool shrinkWrap = false,
    double? cacheExtent,
    ScrollController? controller,
    ChildIndexGetter? findChildIndexCallback,
    int? itemCount,
    double? itemExtent,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool? primary,
    Widget? prototypeItem,
    String? restorationId,
    int? semanticChildCount,
  }) {
    controller = controller ?? ScrollController();
    return _SmoothListViewBuilder(
      key: key,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
      controller: controller,
      curve: curve,
      dragStartBehavior: dragStartBehavior,
      duration: duration,
      enableKeyScrolling: enableKeyScrolling,
      findChildIndexCallback: findChildIndexCallback,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      itemExtent: itemExtent,
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      physics: physics,
      primary: primary,
      prototypeItem: prototypeItem,
      restorationId: restorationId,
      reverse: reverse,
      scrollDirection: scrollDirection,
      semanticChildCount: semanticChildCount,
      shouldScroll: shouldScroll,
      shrinkWrap: shrinkWrap,
      smoothScroll: true,
    );
  }

  /// In a similar approach than the `Switch.adaptive()` constructor, this
  /// implements a smooth version of `ListView.builder()`, but adaptive.
  ///
  /// The constructor matches the `ListView.builder()`'s one, with the exact
  /// same parameters, except for `curve` and `duration` used to customize
  /// the animation, `enableKeyScrolling` to enable scroll while pressing
  /// arrow keys, `shouldScroll` used to decide wether this `ListView`
  /// should be scrollale or not and `smoothScroll`.
  ///
  /// If `smoothScroll` is set, it will be used to determine wether the list
  /// should be animated or not. Otherwise, `smoothScroll` is set to
  /// `(kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS)`
  static Widget adaptiveBuilder({
    Key? key,
    required Duration duration,
    required IndexedWidgetBuilder itemBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    Clip clipBehavior = Clip.hardEdge,
    Curve curve = Curves.easeOut,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool enableKeyScrolling = true,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    bool reverse = false,
    Axis scrollDirection = Axis.vertical,
    bool shouldScroll = true,
    bool shrinkWrap = false,
    double? cacheExtent,
    ScrollController? controller,
    ChildIndexGetter? findChildIndexCallback,
    int? itemCount,
    double? itemExtent,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool? primary,
    Widget? prototypeItem,
    String? restorationId,
    int? semanticChildCount,
    bool? smoothScroll,
  }) {
    smoothScroll = smoothScroll ??
        (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS);
    controller = controller ?? ScrollController();
    return _SmoothListViewBuilder(
      key: key,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
      controller: controller,
      curve: curve,
      dragStartBehavior: dragStartBehavior,
      duration: duration,
      enableKeyScrolling: enableKeyScrolling,
      findChildIndexCallback: findChildIndexCallback,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      itemExtent: itemExtent,
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      physics: physics,
      primary: primary,
      prototypeItem: prototypeItem,
      restorationId: restorationId,
      reverse: reverse,
      scrollDirection: scrollDirection,
      semanticChildCount: semanticChildCount,
      shouldScroll: shouldScroll,
      shrinkWrap: shrinkWrap,
      smoothScroll: smoothScroll,
    );
  }

  /// Implements a smooth version of `ListView.separated()`, mainly for desktop
  /// usage.
  ///
  /// The constructor matches the `ListView.separated()`'s one, with the exact
  /// same parameters, except for `curve` and `duration` used to customize
  /// the animation, `enableKeyScrolling` to enable scroll while pressing
  /// arrow keys and `shouldScroll` used to decide wether this `ListView`
  /// should be scrollale or not.
  static Widget separated({
    Key? key,
    required Duration duration,
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    required Widget Function(BuildContext, int) separatorBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    Clip clipBehavior = Clip.hardEdge,
    Curve curve = Curves.easeOut,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool enableKeyScrolling = true,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    bool reverse = false,
    Axis scrollDirection = Axis.vertical,
    bool shouldScroll = true,
    bool shrinkWrap = false,
    double? cacheExtent,
    ScrollController? controller,
    ChildIndexGetter? findChildIndexCallback,
    double? itemExtent,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool? primary,
    Widget? prototypeItem,
    String? restorationId,
    int? semanticChildCount,
  }) {
    controller = controller ?? ScrollController();
    return _SmoothListViewSeparated(
      key: key,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
      controller: controller,
      curve: curve,
      dragStartBehavior: dragStartBehavior,
      duration: duration,
      enableKeyScrolling: enableKeyScrolling,
      findChildIndexCallback: findChildIndexCallback,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      itemExtent: itemExtent,
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      physics: physics,
      primary: primary,
      prototypeItem: prototypeItem,
      restorationId: restorationId,
      reverse: reverse,
      scrollDirection: scrollDirection,
      semanticChildCount: semanticChildCount,
      separatorBuilder: separatorBuilder,
      shouldScroll: shouldScroll,
      shrinkWrap: shrinkWrap,
      smoothScroll: true,
    );
  }

  /// In a similar approach than the `Switch.adaptive()` constructor, this
  /// implements a smooth version of `ListView.separated()`, but adaptive.
  ///
  /// The constructor matches the `ListView.separated()`'s one, with the exact
  /// same parameters, except for `curve` and `duration` used to customize
  /// the animation, `enableKeyScrolling` to enable scroll while pressing
  /// arrow keys, `shouldScroll` used to decide wether this `ListView`
  /// should be scrollale or not and `smoothScroll`.
  ///
  /// If `smoothScroll` is set, it will be used to determine wether the list
  /// should be animated or not. Otherwise, `smoothScroll` is set to
  /// `(kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS)`
  static Widget adaptiveSeparated({
    Key? key,
    required Duration duration,
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    required Widget Function(BuildContext, int) separatorBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    Clip clipBehavior = Clip.hardEdge,
    Curve curve = Curves.easeOut,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool enableKeyScrolling = true,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    bool reverse = false,
    Axis scrollDirection = Axis.vertical,
    bool shouldScroll = true,
    bool shrinkWrap = false,
    double? cacheExtent,
    ScrollController? controller,
    ChildIndexGetter? findChildIndexCallback,
    double? itemExtent,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool? primary,
    Widget? prototypeItem,
    String? restorationId,
    int? semanticChildCount,
    bool? smoothScroll,
  }) {
    smoothScroll = smoothScroll ??
        (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS);
    controller = controller ?? ScrollController();
    return _SmoothListViewSeparated(
      key: key,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
      controller: controller,
      curve: curve,
      dragStartBehavior: dragStartBehavior,
      duration: duration,
      enableKeyScrolling: enableKeyScrolling,
      findChildIndexCallback: findChildIndexCallback,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      itemExtent: itemExtent,
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      physics: physics,
      primary: primary,
      prototypeItem: prototypeItem,
      restorationId: restorationId,
      reverse: reverse,
      scrollDirection: scrollDirection,
      semanticChildCount: semanticChildCount,
      separatorBuilder: separatorBuilder,
      shouldScroll: shouldScroll,
      shrinkWrap: shrinkWrap,
      smoothScroll: smoothScroll,
    );
  }

  /// In a similar approach than the `Switch.adaptive()` constructor, this
  /// implements a smooth version of `ListView()`, but adaptive.
  ///
  /// The constructor matches the `ListView()`'s one, with the exact
  /// same parameters, except for `curve` and `duration` used to customize
  /// the animation, `enableKeyScrolling` to enable scroll while pressing
  /// arrow keys, `shouldScroll` used to decide wether this `ListView`
  /// should be scrollale or not and `smoothScroll`.
  ///
  /// If `smoothScroll` is set, it will be used to determine wether the list
  /// should be animated or not. Otherwise, `smoothScroll` is set to
  /// `(kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS)`
  static Widget adaptive({
    Key? key,
    required List<Widget> children,
    required Duration duration,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    Clip clipBehavior = Clip.hardEdge,
    Curve curve = Curves.easeOut,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool enableKeyScrolling = true,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    bool reverse = false,
    Axis scrollDirection = Axis.vertical,
    bool shouldScroll = true,
    bool shrinkWrap = false,
    double? cacheExtent,
    ScrollController? controller,
    double? itemExtent,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool? primary,
    Widget? prototypeItem,
    String? restorationId,
    int? semanticChildCount,
    bool? smoothScroll,
  }) {
    smoothScroll = smoothScroll ??
        (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS);
    controller = controller ?? ScrollController();
    return _SmoothListViewItems(
      key: key,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
      controller: controller,
      curve: curve,
      dragStartBehavior: dragStartBehavior,
      duration: duration,
      enableKeyScrolling: enableKeyScrolling,
      itemExtent: itemExtent,
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      physics: physics,
      primary: primary,
      prototypeItem: prototypeItem,
      restorationId: restorationId,
      reverse: reverse,
      scrollDirection: scrollDirection,
      semanticChildCount: semanticChildCount,
      shrinkWrap: shrinkWrap,
      shouldScroll: shouldScroll,
      smoothScroll: smoothScroll,
      children: children,
    );
  }
}

class _SmoothListViewBuilder extends StatefulWidget {
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final Clip clipBehavior;
  final ScrollController controller;
  final Curve curve;
  final DragStartBehavior dragStartBehavior;
  final Duration duration;
  final bool enableKeyScrolling;
  final ChildIndexGetter? findChildIndexCallback;
  final IndexedWidgetBuilder itemBuilder;
  final int? itemCount;
  final double? itemExtent;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool? primary;
  final Widget? prototypeItem;
  final String? restorationId;
  final bool reverse;
  final Axis scrollDirection;
  final int? semanticChildCount;
  final bool shouldScroll;
  final bool shrinkWrap;
  final bool smoothScroll;

  const _SmoothListViewBuilder({
    Key? key,
    required this.addAutomaticKeepAlives,
    required this.addRepaintBoundaries,
    required this.addSemanticIndexes,
    required this.clipBehavior,
    required this.controller,
    required this.curve,
    required this.dragStartBehavior,
    required this.duration,
    required this.enableKeyScrolling,
    required this.itemBuilder,
    required this.keyboardDismissBehavior,
    required this.reverse,
    required this.scrollDirection,
    required this.shouldScroll,
    required this.shrinkWrap,
    required this.smoothScroll,
    this.cacheExtent,
    this.findChildIndexCallback,
    this.itemCount,
    this.itemExtent,
    this.padding,
    this.physics,
    this.primary,
    this.prototypeItem,
    this.restorationId,
    this.semanticChildCount,
  }) : super(key: key);

  @override
  State<_SmoothListViewBuilder> createState() => _SmoothListViewBuilderState();
}

class _SmoothListViewBuilderState extends State<_SmoothListViewBuilder> {
  double targetPos = 0.0;
  bool _shouldAnimate = true;

  void updatePos(double v, {bool updateAnimate = true}) {
    setState(() {
      if (!_shouldAnimate && updateAnimate) _shouldAnimate = true;
      if (v < 0) {
        targetPos = math.max(0.0, targetPos + v);
      } else {
        targetPos =
            math.min(widget.controller.position.maxScrollExtent, targetPos + v);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shouldScroll &&
        widget.smoothScroll &&
        _shouldAnimate &&
        widget.controller.hasClients &&
        targetPos != widget.controller.offset) {
      widget.controller
          .animateTo(targetPos, duration: widget.duration, curve: widget.curve);
    }
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (widget.shouldScroll && widget.enableKeyScrolling) {
          if ((event.isKeyPressed(LogicalKeyboardKey.arrowDown) &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.isKeyPressed(LogicalKeyboardKey.arrowRight) &&
                  widget.scrollDirection == Axis.horizontal)) {
            if (!widget.smoothScroll) {
              widget.controller.jumpTo(math.min(
                  widget.controller.position.maxScrollExtent,
                  widget.controller.offset + 111.0));
            }
            updatePos(111.0);
          } else if ((event.isKeyPressed(LogicalKeyboardKey.arrowUp) &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) &&
                  widget.scrollDirection == Axis.horizontal)) {
            if (!widget.smoothScroll) {
              widget.controller
                  .jumpTo(math.max(0.0, widget.controller.offset - 111.0));
            }
            updatePos(-111.0);
          }
        }
      },
      child: Listener(
        onPointerSignal: (PointerSignalEvent event) {
          if (widget.shouldScroll) {
            if (!_shouldAnimate && event.kind == PointerDeviceKind.trackpad) {
              setState(() {
                _shouldAnimate = false;
              });
              updatePos(widget.controller.offset, updateAnimate: false);
            }
            if (event is PointerScrollEvent && widget.smoothScroll) {
              updatePos(event.scrollDelta.dy);
            }
          }
          if (event is PointerScrollEvent && !widget.smoothScroll) {
            updatePos(event.scrollDelta.dy, updateAnimate: false);
          }
        },
        child: ListView.builder(
          addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
          addRepaintBoundaries: widget.addRepaintBoundaries,
          addSemanticIndexes: widget.addSemanticIndexes,
          cacheExtent: widget.cacheExtent,
          clipBehavior: widget.clipBehavior,
          controller: widget.controller,
          dragStartBehavior: widget.dragStartBehavior,
          findChildIndexCallback: widget.findChildIndexCallback,
          itemBuilder: widget.itemBuilder,
          itemCount: widget.itemCount,
          itemExtent: widget.itemExtent,
          keyboardDismissBehavior: widget.keyboardDismissBehavior,
          padding: widget.padding,
          physics:
              (widget.smoothScroll && _shouldAnimate) || !widget.shouldScroll
                  ? const NeverScrollableScrollPhysics()
                  : widget.physics,
          primary: widget.primary,
          prototypeItem: widget.prototypeItem,
          restorationId: widget.restorationId,
          reverse: widget.reverse,
          scrollDirection: widget.scrollDirection,
          semanticChildCount: widget.semanticChildCount,
          shrinkWrap: widget.shrinkWrap,
        ),
      ),
    );
  }
}

class _SmoothListViewSeparated extends StatefulWidget {
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final Clip clipBehavior;
  final ScrollController controller;
  final Curve curve;
  final DragStartBehavior dragStartBehavior;
  final Duration duration;
  final bool enableKeyScrolling;
  final ChildIndexGetter? findChildIndexCallback;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double? itemExtent;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool? primary;
  final Widget? prototypeItem;
  final String? restorationId;
  final bool reverse;
  final Axis scrollDirection;
  final int? semanticChildCount;
  final Widget Function(BuildContext, int) separatorBuilder;
  final bool shouldScroll;
  final bool shrinkWrap;
  final bool smoothScroll;

  const _SmoothListViewSeparated({
    Key? key,
    required this.addAutomaticKeepAlives,
    required this.addRepaintBoundaries,
    required this.addSemanticIndexes,
    required this.clipBehavior,
    required this.controller,
    required this.curve,
    required this.dragStartBehavior,
    required this.duration,
    required this.enableKeyScrolling,
    required this.itemBuilder,
    required this.itemCount,
    required this.keyboardDismissBehavior,
    required this.reverse,
    required this.scrollDirection,
    required this.separatorBuilder,
    required this.shouldScroll,
    required this.shrinkWrap,
    required this.smoothScroll,
    this.cacheExtent,
    this.findChildIndexCallback,
    this.itemExtent,
    this.padding,
    this.physics,
    this.primary,
    this.prototypeItem,
    this.restorationId,
    this.semanticChildCount,
  }) : super(key: key);

  @override
  State<_SmoothListViewSeparated> createState() =>
      _SmoothListViewSeparatedState();
}

class _SmoothListViewSeparatedState extends State<_SmoothListViewSeparated> {
  double targetPos = 0.0;
  bool _shouldAnimate = true;

  void updatePos(double v, {bool updateAnimate = true}) {
    setState(() {
      if (!_shouldAnimate && updateAnimate) _shouldAnimate = true;
      if (v < 0) {
        targetPos = math.max(0.0, targetPos + v);
      } else {
        targetPos =
            math.min(widget.controller.position.maxScrollExtent, targetPos + v);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shouldScroll &&
        widget.smoothScroll &&
        _shouldAnimate &&
        widget.controller.hasClients &&
        targetPos != widget.controller.offset) {
      widget.controller
          .animateTo(targetPos, duration: widget.duration, curve: widget.curve);
    }
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (widget.shouldScroll && widget.enableKeyScrolling) {
          if ((event.isKeyPressed(LogicalKeyboardKey.arrowDown) &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.isKeyPressed(LogicalKeyboardKey.arrowRight) &&
                  widget.scrollDirection == Axis.horizontal)) {
            if (!widget.smoothScroll) {
              widget.controller.jumpTo(math.min(
                  widget.controller.position.maxScrollExtent,
                  widget.controller.offset + 111.0));
            }
            updatePos(111.0);
          } else if ((event.isKeyPressed(LogicalKeyboardKey.arrowUp) &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) &&
                  widget.scrollDirection == Axis.horizontal)) {
            if (!widget.smoothScroll) {
              widget.controller
                  .jumpTo(math.max(0.0, widget.controller.offset - 111.0));
            }
            updatePos(-111.0);
          }
        }
      },
      child: Listener(
        onPointerSignal: (PointerSignalEvent event) {
          if (widget.shouldScroll) {
            if (!_shouldAnimate && event.kind == PointerDeviceKind.trackpad) {
              setState(() {
                _shouldAnimate = false;
              });
              updatePos(widget.controller.offset, updateAnimate: false);
            }
            if (event is PointerScrollEvent && widget.smoothScroll) {
              updatePos(event.scrollDelta.dy);
            }
          }
          if (event is PointerScrollEvent && !widget.smoothScroll) {
            updatePos(event.scrollDelta.dy, updateAnimate: false);
          }
        },
        child: ListView.separated(
          addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
          addRepaintBoundaries: widget.addRepaintBoundaries,
          addSemanticIndexes: widget.addSemanticIndexes,
          cacheExtent: widget.cacheExtent,
          clipBehavior: widget.clipBehavior,
          controller: widget.controller,
          dragStartBehavior: widget.dragStartBehavior,
          findChildIndexCallback: widget.findChildIndexCallback,
          itemBuilder: widget.itemBuilder,
          itemCount: widget.itemCount,
          keyboardDismissBehavior: widget.keyboardDismissBehavior,
          padding: widget.padding,
          physics:
              (widget.smoothScroll && _shouldAnimate) || !widget.shouldScroll
                  ? const NeverScrollableScrollPhysics()
                  : widget.physics,
          primary: widget.primary,
          restorationId: widget.restorationId,
          reverse: widget.reverse,
          scrollDirection: widget.scrollDirection,
          separatorBuilder: widget.separatorBuilder,
          shrinkWrap: widget.shrinkWrap,
        ),
      ),
    );
  }
}

class _SmoothListViewItems extends StatefulWidget {
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final List<Widget> children;
  final Clip clipBehavior;
  final ScrollController controller;
  final Curve curve;
  final DragStartBehavior dragStartBehavior;
  final Duration duration;
  final bool enableKeyScrolling;
  final double? itemExtent;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool? primary;
  final Widget? prototypeItem;
  final Axis scrollDirection;
  final int? semanticChildCount;
  final bool shouldScroll;
  final bool shrinkWrap;
  final bool smoothScroll;

  const _SmoothListViewItems({
    Key? key,
    required this.addAutomaticKeepAlives,
    required this.addRepaintBoundaries,
    required this.addSemanticIndexes,
    required this.children,
    required this.clipBehavior,
    required this.controller,
    required this.curve,
    required this.dragStartBehavior,
    required this.duration,
    required this.enableKeyScrolling,
    required this.keyboardDismissBehavior,
    required this.reverse,
    required this.scrollDirection,
    required this.shouldScroll,
    required this.shrinkWrap,
    required this.smoothScroll,
    this.cacheExtent,
    this.itemExtent,
    this.restorationId,
    this.padding,
    this.physics,
    this.primary,
    this.prototypeItem,
    this.semanticChildCount,
  }) : super(key: key);

  @override
  State<_SmoothListViewItems> createState() => _SmoothListViewItemsState();
}

class _SmoothListViewItemsState extends State<_SmoothListViewItems> {
  double targetPos = 0.0;
  bool _shouldAnimate = false;

  void updatePos(double v, {bool updateAnimate = true}) {
    setState(() {
      if (!_shouldAnimate && updateAnimate) _shouldAnimate = true;
      if (v < 0) {
        targetPos = math.max(0.0, targetPos + v);
      } else {
        targetPos =
            math.min(widget.controller.position.maxScrollExtent, targetPos + v);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shouldScroll &&
        widget.smoothScroll &&
        _shouldAnimate &&
        widget.controller.hasClients &&
        targetPos != widget.controller.offset) {
      widget.controller
          .animateTo(targetPos, duration: widget.duration, curve: widget.curve);
    }
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (widget.shouldScroll && widget.enableKeyScrolling) {
          if ((event.isKeyPressed(LogicalKeyboardKey.arrowDown) &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.isKeyPressed(LogicalKeyboardKey.arrowRight) &&
                  widget.scrollDirection == Axis.horizontal)) {
            if (!widget.smoothScroll) {
              widget.controller.jumpTo(math.min(
                  widget.controller.position.maxScrollExtent,
                  widget.controller.offset + 111.0));
            }
            updatePos(111.0);
          } else if ((event.isKeyPressed(LogicalKeyboardKey.arrowUp) &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) &&
                  widget.scrollDirection == Axis.horizontal)) {
            if (!widget.smoothScroll) {
              widget.controller
                  .jumpTo(math.max(0.0, widget.controller.offset - 111.0));
            }
            updatePos(-111.0);
          }
        }
      },
      child: Listener(
        onPointerSignal: (PointerSignalEvent event) {
          if (widget.shouldScroll) {
            if (!_shouldAnimate && event.kind == PointerDeviceKind.trackpad) {
              setState(() {
                _shouldAnimate = false;
              });
              updatePos(widget.controller.offset, updateAnimate: false);
            }
            if (event is PointerScrollEvent && widget.smoothScroll) {
              updatePos(event.scrollDelta.dy);
            }
          }
          if (event is PointerScrollEvent && !widget.smoothScroll) {
            updatePos(event.scrollDelta.dy, updateAnimate: false);
          }
        },
        child: ListView(
          addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
          addRepaintBoundaries: widget.addRepaintBoundaries,
          addSemanticIndexes: widget.addSemanticIndexes,
          cacheExtent: widget.cacheExtent,
          clipBehavior: widget.clipBehavior,
          controller: widget.controller,
          dragStartBehavior: widget.dragStartBehavior,
          itemExtent: widget.itemExtent,
          keyboardDismissBehavior: widget.keyboardDismissBehavior,
          padding: widget.padding,
          physics:
              (widget.smoothScroll && _shouldAnimate) || !widget.shouldScroll
                  ? const NeverScrollableScrollPhysics()
                  : widget.physics,
          primary: widget.primary,
          prototypeItem: widget.prototypeItem,
          restorationId: widget.restorationId,
          reverse: widget.reverse,
          scrollDirection: widget.scrollDirection,
          semanticChildCount: widget.semanticChildCount,
          shrinkWrap: widget.shrinkWrap,
          children: widget.children,
        ),
      ),
    );
  }
}

class _SmoothListViewCustom extends StatefulWidget {
  final double? cacheExtent;
  final SliverChildDelegate childrenDelegate;
  final Clip clipBehavior;
  final ScrollController controller;
  final Curve curve;
  final DragStartBehavior dragStartBehavior;
  final Duration duration;
  final bool enableKeyScrolling;
  final double? itemExtent;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool? primary;
  final Widget? prototypeItem;
  final String? restorationId;
  final bool reverse;
  final Axis scrollDirection;
  final int? semanticChildCount;
  final bool shouldScroll;
  final bool shrinkWrap;
  final bool smoothScroll;

  const _SmoothListViewCustom({
    Key? key,
    required this.childrenDelegate,
    required this.clipBehavior,
    required this.controller,
    required this.curve,
    required this.dragStartBehavior,
    required this.duration,
    required this.enableKeyScrolling,
    required this.keyboardDismissBehavior,
    required this.reverse,
    required this.scrollDirection,
    required this.shouldScroll,
    required this.shrinkWrap,
    required this.smoothScroll,
    this.cacheExtent,
    this.itemExtent,
    this.padding,
    this.physics,
    this.primary,
    this.prototypeItem,
    this.restorationId,
    this.semanticChildCount,
  }) : super(key: key);

  @override
  State<_SmoothListViewCustom> createState() => _SmoothListViewCustomState();
}

class _SmoothListViewCustomState extends State<_SmoothListViewCustom> {
  double targetPos = 0.0;
  bool _shouldAnimate = true;

  void updatePos(double v, {bool updateAnimate = true}) {
    setState(() {
      if (!_shouldAnimate && updateAnimate) _shouldAnimate = true;
      if (v < 0) {
        targetPos = math.max(0.0, targetPos + v);
      } else {
        targetPos =
            math.min(widget.controller.position.maxScrollExtent, targetPos + v);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shouldScroll &&
        widget.smoothScroll &&
        _shouldAnimate &&
        widget.controller.hasClients &&
        targetPos != widget.controller.offset) {
      widget.controller
          .animateTo(targetPos, duration: widget.duration, curve: widget.curve);
    }
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (widget.shouldScroll && widget.enableKeyScrolling) {
          if ((event.isKeyPressed(LogicalKeyboardKey.arrowDown) &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.isKeyPressed(LogicalKeyboardKey.arrowRight) &&
                  widget.scrollDirection == Axis.horizontal)) {
            if (!widget.smoothScroll) {
              widget.controller.jumpTo(math.min(
                  widget.controller.position.maxScrollExtent,
                  widget.controller.offset + 111.0));
            }
            updatePos(111.0);
          } else if ((event.isKeyPressed(LogicalKeyboardKey.arrowUp) &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) &&
                  widget.scrollDirection == Axis.horizontal)) {
            if (!widget.smoothScroll) {
              widget.controller
                  .jumpTo(math.max(0.0, widget.controller.offset - 111.0));
            }
            updatePos(-111.0);
          }
        }
      },
      child: Listener(
        onPointerSignal: (PointerSignalEvent event) {
          if (widget.shouldScroll) {
            if (!_shouldAnimate && event.kind == PointerDeviceKind.trackpad) {
              setState(() {
                _shouldAnimate = false;
              });
              updatePos(widget.controller.offset, updateAnimate: false);
            }
            if (event is PointerScrollEvent && widget.smoothScroll) {
              updatePos(event.scrollDelta.dy);
            }
          }
          if (event is PointerScrollEvent && !widget.smoothScroll) {
            updatePos(event.scrollDelta.dy, updateAnimate: false);
          }
        },
        child: ListView.custom(
          cacheExtent: widget.cacheExtent,
          childrenDelegate: widget.childrenDelegate,
          clipBehavior: widget.clipBehavior,
          controller: widget.controller,
          dragStartBehavior: widget.dragStartBehavior,
          itemExtent: widget.itemExtent,
          keyboardDismissBehavior: widget.keyboardDismissBehavior,
          padding: widget.padding,
          physics:
              (widget.smoothScroll && _shouldAnimate) || !widget.shouldScroll
                  ? const NeverScrollableScrollPhysics()
                  : widget.physics,
          primary: widget.primary,
          prototypeItem: widget.prototypeItem,
          restorationId: widget.restorationId,
          reverse: widget.reverse,
          scrollDirection: widget.scrollDirection,
          semanticChildCount: widget.semanticChildCount,
          shrinkWrap: widget.shrinkWrap,
        ),
      ),
    );
  }
}
