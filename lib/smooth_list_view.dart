library smooth_list_view;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
  final ScrollController controller;
  final Curve curve;
  final DragStartBehavior dragStartBehavior;
  final Duration duration;
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
  final bool shrinkWrap;

  const SmoothListView({
    Key? key,
    required this.controller,
    required this.duration,
    required this.children,
    this.curve = Curves.easeOut,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.shrinkWrap = false,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.addAutomaticKeepAlives = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.clipBehavior = Clip.hardEdge,
    this.primary,
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    this.cacheExtent,
    this.semanticChildCount,
    this.restorationId,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SmoothListViewItems(
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
      controller: controller,
      dragStartBehavior: dragStartBehavior,
      itemExtent: itemExtent,
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      primary: primary,
      prototypeItem: prototypeItem,
      restorationId: restorationId,
      reverse: reverse,
      scrollDirection: scrollDirection,
      semanticChildCount: semanticChildCount,
      shrinkWrap: shrinkWrap,
      curve: curve,
      duration: duration,
      physics: physics,
      children: children,
    );
  }

  /// Implements a smooth version of `ListView.builder()`, mainly for desktop
  /// usage.
  ///
  /// The constructor matches the `ListView.builder()`'s one, with the exact
  /// same parameters except for `curve` and `duration`, used to customize
  /// the animation.
  static Widget builder({
    Key? key,
    required IndexedWidgetBuilder itemBuilder,
    required Duration duration,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    Widget? prototypeItem,
    ChildIndexGetter? findChildIndexCallback,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Curve curve = Curves.easeOut,
    ScrollPhysics? physics,
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
      dragStartBehavior: dragStartBehavior,
      findChildIndexCallback: findChildIndexCallback,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      itemExtent: itemExtent,
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      primary: primary,
      prototypeItem: prototypeItem,
      restorationId: restorationId,
      reverse: reverse,
      scrollDirection: scrollDirection,
      semanticChildCount: semanticChildCount,
      shrinkWrap: shrinkWrap,
      curve: curve,
      duration: duration,
      physics: physics,
    );
  }

  /// In a similar approach than the `Switch.adaptive()` constructor, this
  /// implements a smooth version of `ListView.builder()`, but adaptive.
  ///
  /// The constructor matches the `ListView.builder()`'s one, with the exact
  /// same parameters, except for `curve` and `duration` used to customize
  /// the animation and `smoothScroll`.
  ///
  /// If `smoothScroll` is set, it will be used to determine wether the list
  /// should be animated or not. Otherwise, `smoothScroll` is set to
  /// `(kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS)`
  static Widget adaptiveBuilder({
    Key? key,
    required IndexedWidgetBuilder itemBuilder,
    Duration duration = const Duration(milliseconds: 100),
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    Widget? prototypeItem,
    ChildIndexGetter? findChildIndexCallback,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Curve curve = Curves.easeOut,
    ScrollPhysics? physics,
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
      dragStartBehavior: dragStartBehavior,
      findChildIndexCallback: findChildIndexCallback,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      itemExtent: itemExtent,
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      primary: primary,
      prototypeItem: prototypeItem,
      restorationId: restorationId,
      reverse: reverse,
      scrollDirection: scrollDirection,
      semanticChildCount: semanticChildCount,
      shrinkWrap: shrinkWrap,
      curve: curve,
      physics: physics,
      duration: duration,
      smoothScroll: smoothScroll,
    );
  }

  /// In a similar approach than the `Switch.adaptive()` constructor, this
  /// implements a smooth version of `ListView()`, but adaptive.
  ///
  /// The constructor matches the `ListView()`'s one, with the exact
  /// same parameters, except for `curve` and `duration` used to customize
  /// the animation and `smoothScroll`.
  ///
  /// If `smoothScroll` is set, it will be used to determine wether the list
  /// should be animated or not. Otherwise, `smoothScroll` is set to
  /// `(kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS)`
  static Widget adaptive({
    Key? key,
    required Duration duration,
    required List<Widget> children,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    Widget? prototypeItem,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Curve curve = Curves.easeOut,
    ScrollPhysics? physics,
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
      dragStartBehavior: dragStartBehavior,
      itemExtent: itemExtent,
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      primary: primary,
      prototypeItem: prototypeItem,
      restorationId: restorationId,
      reverse: reverse,
      scrollDirection: scrollDirection,
      semanticChildCount: semanticChildCount,
      shrinkWrap: shrinkWrap,
      curve: curve,
      duration: duration,
      physics: physics,
      smoothScroll: smoothScroll,
      children: children,
    );
  }
}

class _SmoothListViewBuilder extends StatefulWidget {
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController controller;
  final bool? primary;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;
  final Widget? prototypeItem;
  final IndexedWidgetBuilder itemBuilder;
  final ChildIndexGetter? findChildIndexCallback;
  final int? itemCount;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final Curve curve;
  final Duration duration;
  final ScrollPhysics? physics;
  final bool smoothScroll;

  const _SmoothListViewBuilder({
    Key? key,
    required this.controller,
    required this.curve,
    required this.duration,
    required this.itemBuilder,
    this.smoothScroll = true,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.shrinkWrap = false,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.addAutomaticKeepAlives = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.clipBehavior = Clip.hardEdge,
    this.primary,
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    this.findChildIndexCallback,
    this.itemCount,
    this.cacheExtent,
    this.semanticChildCount,
    this.restorationId,
    this.physics = const BouncingScrollPhysics(),
  }) : super(key: key);

  @override
  State<_SmoothListViewBuilder> createState() => _SmoothListViewBuilderState();
}

class _SmoothListViewBuilderState extends State<_SmoothListViewBuilder> {
  double targetPos = 0.0;
  bool _shouldAnimate = false;

  void updatePos(double v) {
    setState(() {
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
    if (widget.smoothScroll &&
        _shouldAnimate &&
        widget.controller.hasClients &&
        targetPos != widget.controller.offset) {
      widget.controller
          .animateTo(targetPos, duration: widget.duration, curve: widget.curve);
    }
    return Listener(
      onPointerSignal: (PointerSignalEvent event) {
        if (!_shouldAnimate && event.kind == PointerDeviceKind.trackpad) {
          setState(() {
            _shouldAnimate = false;
          });
        }
        if (event is PointerScrollEvent) {
          if (widget.smoothScroll) {
            setState(() {
              _shouldAnimate = true;
            });
          }
          if (_shouldAnimate) {
            updatePos(widget.scrollDirection == Axis.vertical
                ? event.scrollDelta.dy
                : event.scrollDelta.dx);
          }
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
        physics: (widget.smoothScroll && _shouldAnimate)
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
    );
  }
}

class _SmoothListViewItems extends StatefulWidget {
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController controller;
  final bool? primary;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;
  final Widget? prototypeItem;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;
  final List<Widget> children;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final Curve curve;
  final Duration duration;
  final ScrollPhysics? physics;
  final bool smoothScroll;

  const _SmoothListViewItems({
    Key? key,
    required this.controller,
    required this.curve,
    required this.duration,
    required this.children,
    this.smoothScroll = true,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.shrinkWrap = false,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.addAutomaticKeepAlives = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.clipBehavior = Clip.hardEdge,
    this.primary,
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    this.cacheExtent,
    this.semanticChildCount,
    this.restorationId,
    this.physics = const BouncingScrollPhysics(),
  }) : super(key: key);

  @override
  State<_SmoothListViewItems> createState() => _SmoothListViewItemsState();
}

class _SmoothListViewItemsState extends State<_SmoothListViewItems> {
  double targetPos = 0.0;
  bool _shouldAnimate = false;

  void updatePos(double v) {
    setState(() {
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
    if (widget.smoothScroll &&
        _shouldAnimate &&
        widget.controller.hasClients &&
        targetPos != widget.controller.offset) {
      widget.controller
          .animateTo(targetPos, duration: widget.duration, curve: widget.curve);
    }
    return Listener(
      onPointerSignal: (PointerSignalEvent event) {
        if (!_shouldAnimate && event.kind == PointerDeviceKind.trackpad) {
          setState(() {
            _shouldAnimate = false;
          });
        }
        if (event is PointerScrollEvent) {
          if (widget.smoothScroll) {
            setState(() {
              _shouldAnimate = true;
            });
          }
          if (_shouldAnimate) {
            updatePos(widget.scrollDirection == Axis.vertical
                ? event.scrollDelta.dy
                : event.scrollDelta.dx);
          }
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
        physics: widget.smoothScroll && _shouldAnimate
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
    );
  }
}
