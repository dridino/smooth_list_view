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
  final bool smoothScroll;

  const SmoothListView({
    super.key,
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
    this.smoothScroll = true,
    this.cacheExtent,
    this.controller,
    this.itemExtent,
    this.padding,
    this.physics,
    this.primary,
    this.prototypeItem,
    this.restorationId,
    this.semanticChildCount,
  });

  @override
  Widget build(BuildContext context) {
    final bool newSmoothScroll = smoothScroll &&
        (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS);
    final ScrollController newController = controller ?? ScrollController();
    return _SmoothListViewItems(
      key: key,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
      controller: newController,
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
      smoothScroll: newSmoothScroll,
      children: children,
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
    bool smoothScroll = true,
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
    smoothScroll = smoothScroll &&
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
    bool smoothScroll = true,
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
    smoothScroll = smoothScroll &&
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
  /// implements a smooth version of `ListView.custom()`, but adaptive.
  ///
  /// The constructor matches the `ListView.custom()`'s one, with the exact
  /// same parameters, except for `curve` and `duration` used to customize
  /// the animation, `enableKeyScrolling` to enable scroll while pressing
  /// arrow keys, `shouldScroll` used to decide wether this `ListView`
  /// should be scrollale or not and `smoothScroll`.
  ///
  /// If `smoothScroll` is set, it will be used to determine wether the list
  /// should be animated or not. Otherwise, `smoothScroll` is set to
  /// `(kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS)`
  static Widget custom({
    Key? key,
    required SliverChildDelegate childrenDelegate,
    required Duration duration,
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
    bool smoothScroll = true,
    double? cacheExtent,
    ScrollController? controller,
    double? itemExtent,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool? primary,
    Widget? prototypeItem,
    String? restorationId,
    int? semanticChildCount,
  }) {
    smoothScroll = smoothScroll &&
        (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS);
    controller = controller ?? ScrollController();
    return _SmoothListViewCustom(
      key: key,
      cacheExtent: cacheExtent,
      childrenDelegate: childrenDelegate,
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
      shouldScroll: shouldScroll,
      shrinkWrap: shrinkWrap,
      smoothScroll: smoothScroll,
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
    super.key,
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
  });

  @override
  State<_SmoothListViewBuilder> createState() => _SmoothListViewBuilderState();
}

class _SmoothListViewBuilderState extends State<_SmoothListViewBuilder> {
  double targetPos = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (!widget.smoothScroll) {
        targetPos = widget.controller.offset;
      }
    });
  }

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
    if (widget.shouldScroll &&
        widget.smoothScroll &&
        widget.controller.hasClients &&
        targetPos != widget.controller.offset) {
      widget.controller
          .animateTo(targetPos, duration: widget.duration, curve: widget.curve);
    }

    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (event) {
        if (widget.enableKeyScrolling) {
          if ((event.logicalKey == LogicalKeyboardKey.arrowDown &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.logicalKey == LogicalKeyboardKey.arrowRight &&
                  widget.scrollDirection == Axis.horizontal)) {
            if (!widget.smoothScroll) {
              widget.controller.jumpTo(math.min(
                  widget.controller.position.maxScrollExtent,
                  widget.controller.offset + 111.0));
            }
            updatePos(111.0);
          } else if ((event.logicalKey == LogicalKeyboardKey.arrowUp &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
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
        onPointerPanZoomUpdate: (event) {
          if (widget.smoothScroll) {
            updatePos((widget.scrollDirection == Axis.vertical
                    ? -event.panDelta.dy
                    : -event.panDelta.dx) *
                2);
          }
        },
        onPointerSignal: (PointerSignalEvent event) {
          if (event is PointerScrollEvent) {
            updatePos(event.scrollDelta.dy);
            if (!widget.smoothScroll) {
              widget.controller
                  .jumpTo(widget.controller.offset + event.scrollDelta.dy);
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
          physics: widget.smoothScroll || !widget.shouldScroll
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
    super.key,
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
  });

  @override
  State<_SmoothListViewSeparated> createState() =>
      _SmoothListViewSeparatedState();
}

class _SmoothListViewSeparatedState extends State<_SmoothListViewSeparated> {
  double targetPos = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (!widget.smoothScroll) {
        targetPos = widget.controller.offset;
      }
    });
  }

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
    if (widget.shouldScroll &&
        widget.smoothScroll &&
        widget.controller.hasClients &&
        targetPos != widget.controller.offset) {
      widget.controller
          .animateTo(targetPos, duration: widget.duration, curve: widget.curve);
    }
    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (event) {
        if (widget.enableKeyScrolling) {
          if ((event.logicalKey == LogicalKeyboardKey.arrowDown &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.logicalKey == LogicalKeyboardKey.arrowRight &&
                  widget.scrollDirection == Axis.horizontal)) {
            if (!widget.smoothScroll) {
              widget.controller.jumpTo(math.min(
                  widget.controller.position.maxScrollExtent,
                  widget.controller.offset + 111.0));
            }
            updatePos(111.0);
          } else if ((event.logicalKey == LogicalKeyboardKey.arrowUp &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
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
        onPointerPanZoomUpdate: (event) {
          if (widget.smoothScroll) {
            updatePos((widget.scrollDirection == Axis.vertical
                    ? -event.panDelta.dy
                    : -event.panDelta.dx) *
                2);
          }
        },
        onPointerSignal: (PointerSignalEvent event) {
          if (event is PointerScrollEvent) {
            updatePos(event.scrollDelta.dy);
            if (!widget.smoothScroll) {
              widget.controller
                  .jumpTo(widget.controller.offset + event.scrollDelta.dy);
            }
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
          physics: widget.smoothScroll || !widget.shouldScroll
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
    super.key,
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
  });

  @override
  State<_SmoothListViewItems> createState() => _SmoothListViewItemsState();
}

class _SmoothListViewItemsState extends State<_SmoothListViewItems> {
  double targetPos = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (!widget.smoothScroll) {
        targetPos = widget.controller.offset;
      }
    });
  }

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
    if (widget.shouldScroll &&
        widget.smoothScroll &&
        widget.controller.hasClients &&
        targetPos != widget.controller.offset) {
      widget.controller
          .animateTo(targetPos, duration: widget.duration, curve: widget.curve);
    }
    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (event) {
        if (widget.enableKeyScrolling) {
          if ((event.logicalKey == LogicalKeyboardKey.arrowDown &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.logicalKey == LogicalKeyboardKey.arrowRight &&
                  widget.scrollDirection == Axis.horizontal)) {
            if (!widget.smoothScroll) {
              widget.controller.jumpTo(math.min(
                  widget.controller.position.maxScrollExtent,
                  widget.controller.offset + 111.0));
            }
            updatePos(111.0);
          } else if ((event.logicalKey == LogicalKeyboardKey.arrowUp &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
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
        onPointerPanZoomUpdate: (event) {
          if (widget.smoothScroll) {
            updatePos((widget.scrollDirection == Axis.vertical
                    ? -event.panDelta.dy
                    : -event.panDelta.dx) *
                2);
          }
        },
        onPointerSignal: (PointerSignalEvent event) {
          if (event is PointerScrollEvent) {
            updatePos(event.scrollDelta.dy);
            if (!widget.smoothScroll) {
              widget.controller
                  .jumpTo(widget.controller.offset + event.scrollDelta.dy);
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
          physics: widget.smoothScroll || !widget.shouldScroll
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
    super.key,
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
  });

  @override
  State<_SmoothListViewCustom> createState() => _SmoothListViewCustomState();
}

class _SmoothListViewCustomState extends State<_SmoothListViewCustom> {
  double targetPos = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (!widget.smoothScroll) {
        targetPos = widget.controller.offset;
      }
    });
  }

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
    if (widget.shouldScroll &&
        widget.smoothScroll &&
        widget.controller.hasClients &&
        targetPos != widget.controller.offset) {
      widget.controller
          .animateTo(targetPos, duration: widget.duration, curve: widget.curve);
    }
    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (event) {
        if (widget.enableKeyScrolling) {
          if ((event.logicalKey == LogicalKeyboardKey.arrowDown &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.logicalKey == LogicalKeyboardKey.arrowRight &&
                  widget.scrollDirection == Axis.horizontal)) {
            if (!widget.smoothScroll) {
              widget.controller.jumpTo(math.min(
                  widget.controller.position.maxScrollExtent,
                  widget.controller.offset + 111.0));
            }
            updatePos(111.0);
          } else if ((event.logicalKey == LogicalKeyboardKey.arrowUp &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
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
        onPointerPanZoomUpdate: (event) {
          if (widget.smoothScroll) {
            updatePos((widget.scrollDirection == Axis.vertical
                    ? -event.panDelta.dy
                    : -event.panDelta.dx) *
                2);
          }
        },
        onPointerSignal: (PointerSignalEvent event) {
          if (event is PointerScrollEvent) {
            updatePos(event.scrollDelta.dy);
            if (!widget.smoothScroll) {
              widget.controller
                  .jumpTo(widget.controller.offset + event.scrollDelta.dy);
            }
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
          physics: widget.smoothScroll || !widget.shouldScroll
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
