library smooth_list_view;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math' as math;
import 'dart:io' show Platform;

//! TODO : shouldScroll ?
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
    final bool isDesktop =
        kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS;
    final bool newSmoothScroll = smoothScroll && isDesktop;
    final ScrollController newController = controller ?? ScrollController();
    final Widget child = _SmoothListViewItems(
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
    return child;
  }

  /// In a similar approach than the `Switch.adaptive()` constructor, this
  /// implements a smooth version of `ListView.builder()`, but adaptive.
  ///
  /// The constructor matches the `ListView.builder()`'s one, with the exact
  /// same parameters, except for `curve` and `duration` used to customize
  /// the animation, `enableKeyScrolling` to enable scroll while pressing
  /// arrow keys, `shouldScroll` used to decide wether this `ListView`
  /// should be scrollable or not and `smoothScroll`.
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
    final bool isDesktop =
        kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS;
    smoothScroll = smoothScroll && isDesktop;
    controller = controller ?? ScrollController();
    final Widget child = _SmoothListViewBuilder(
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
    return child;
  }

  /// In a similar approach than the `Switch.adaptive()` constructor, this
  /// implements a smooth version of `ListView.separated()`, but adaptive.
  ///
  /// The constructor matches the `ListView.separated()`'s one, with the exact
  /// same parameters, except for `curve` and `duration` used to customize
  /// the animation, `enableKeyScrolling` to enable scroll while pressing
  /// arrow keys, `shouldScroll` used to decide wether this `ListView`
  /// should be scrollable or not and `smoothScroll`.
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
    final bool isDesktop =
        kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS;
    smoothScroll = smoothScroll && isDesktop;
    controller = controller ?? ScrollController();
    final Widget child = _SmoothListViewSeparated(
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
    return child;
  }

  /// In a similar approach than the `Switch.adaptive()` constructor, this
  /// implements a smooth version of `ListView.custom()`, but adaptive.
  ///
  /// The constructor matches the `ListView.custom()`'s one, with the exact
  /// same parameters, except for `curve` and `duration` used to customize
  /// the animation, `enableKeyScrolling` to enable scroll while pressing
  /// arrow keys, `shouldScroll` used to decide wether this `ListView`
  /// should be scrollable or not and `smoothScroll`.
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
    final bool isDesktop =
        kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS;
    smoothScroll = smoothScroll && isDesktop;
    controller = controller ?? ScrollController();
    final Widget child = _SmoothListViewCustom(
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
    return child;
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
  double target = 0.0;
  late _AnimationHandler animationHandler;

  @override
  void initState() {
    super.initState();
    animationHandler = _AnimationHandler(
      targetPos: widget.controller.initialScrollOffset,
      isAnimating: false,
      shouldScroll: widget.shouldScroll,
      smoothScroll: widget.smoothScroll,
      controller: widget.controller,
      duration: widget.duration,
      curve: widget.curve,
    );
    widget.controller.addListener(() {
      debugPrint("controller");
      //debugPrint("controller");
      if (!animationHandler.isAnimating ||
          animationHandler.waitingForController) {
        //debugPrint("good");
        animationHandler.setTargetPos(widget.controller.offset);
      }
    });
  }

  @override
  void didUpdateWidget(covariant _SmoothListViewBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHandler = _AnimationHandler(
      targetPos: widget.controller.initialScrollOffset,
      isAnimating: false,
      shouldScroll: widget.shouldScroll,
      smoothScroll: widget.smoothScroll,
      controller: widget.controller,
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  double bound(double val) {
    return math.min(
        widget.controller.position.maxScrollExtent, math.max(0.0, val));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shouldScroll &&
        widget.smoothScroll &&
        widget.controller.hasClients &&
        animationHandler.targetRaw != widget.controller.offset &&
        !animationHandler.waitingForController) {
      //debugPrint("here");
      widget.controller
          .animateTo(animationHandler.targetRaw,
              duration: widget.duration, curve: widget.curve)
          .then((_) => setState(() {}));
    } else if (widget.shouldScroll &&
        widget.smoothScroll &&
        widget.controller.hasClients &&
        animationHandler.targetRaw == widget.controller.offset &&
        !animationHandler.waitingForController) {
      animationHandler.setIsAnimating(false);
    }
    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (event) {
        /* if (widget.enableKeyScrolling) {
          int factor = 0;
          if ((event.logicalKey == LogicalKeyboardKey.arrowDown &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.logicalKey == LogicalKeyboardKey.arrowRight &&
                  widget.scrollDirection == Axis.horizontal)) {
            factor = 1;
          } else if ((event.logicalKey == LogicalKeyboardKey.arrowUp &&
                  widget.scrollDirection == Axis.vertical) ||
              (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
                  widget.scrollDirection == Axis.horizontal)) {
            factor = -1;
          }
          final double newPos = updatePos(
            scrollController: widget.controller,
            scrollDelta: factor * 111.0,
            target: target,
            compensate: false,
          );
          if (!widget.smoothScroll) {
            widget.controller.jumpTo(newPos);
          } else {
            setState(() {
              target = newPos;
            });
          }
        } */
      },
      child: Listener(
        onPointerSignal: (PointerSignalEvent event) {
          if (event is PointerScrollEvent && widget.smoothScroll) {
            final double delta = widget.scrollDirection == Axis.vertical
                ? event.delta.dy
                : event.delta.dx;
            final double newPos =
                bound(animationHandler.targetRaw + event.scrollDelta.dy);
            /* 
            animationHandler.send(
                NotificationType.animation,
                delta,
                math.min(widget.controller.position.maxScrollExtent,
                    math.max(0.0, newPos)));
            setState(() {
              target = newPos;
              i = 2;
            }); */
            late double dest;
            if (widget.controller.offset + event.scrollDelta.dy <=
                widget.controller.position.maxScrollExtent) {
              if (widget.controller.offset + event.scrollDelta.dy >= 0) {
                dest = (widget.controller.offset - event.scrollDelta.dy);
              } else {
                dest = (2 * widget.controller.offset);
              }
            } else {
              dest = (widget.controller.offset -
                  (widget.controller.position.maxScrollExtent -
                      widget.controller.offset));
            }
            debugPrint(widget.controller.offset.toString());
            debugPrint(dest.toString());
            debugPrint(newPos.toString());
            debugPrint("max : ${widget.controller.position.maxScrollExtent}\n");
            // widget.controller.jumpTo(dest);
            /* if (widget.controller.offset + event.scrollDelta.dy <=
                    widget.controller.position.maxScrollExtent &&
                widget.controller.offset + event.scrollDelta.dy >= 0) {
              widget.controller
                  .jumpTo(widget.controller.offset - event.scrollDelta.dy);
            } */
            // widget.controller.jumpTo(bound(widget.controller.offset - delta));
            animationHandler.setIsAnimating(true);
            animationHandler.setTargetPos(newPos, widget.controller.offset);
            setState(() {});
            //debugPrint("listener");
            //? provider ?
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
          physics: widget.physics,
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
  bool scrollBarScroll = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.offset == targetPos) {
        scrollBarScroll = true;
      }
      if (!widget.smoothScroll || scrollBarScroll) {
        targetPos = widget.controller.offset;
      }
    });
  }

  void updatePos(double v) {
    setState(() {
      scrollBarScroll = false;
      if (!widget.smoothScroll) {
        targetPos = widget.controller.offset;
      }
    });
  }

  Widget wrapAbsorbPointer({required bool pred, required Widget child}) {
    return pred ? AbsorbPointer(child: child) : child;
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
        child: wrapAbsorbPointer(
          pred: widget.smoothScroll || !widget.shouldScroll,
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
            physics: widget.physics,
            primary: widget.primary,
            restorationId: widget.restorationId,
            reverse: widget.reverse,
            scrollDirection: widget.scrollDirection,
            separatorBuilder: widget.separatorBuilder,
            shrinkWrap: widget.shrinkWrap,
          ),
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

  bool scrollBarScroll = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.offset == targetPos) {
        scrollBarScroll = true;
      }
      if (!widget.smoothScroll || scrollBarScroll) {
        targetPos = widget.controller.offset;
      }
    });
  }

  void updatePos(double v) {
    setState(() {
      scrollBarScroll = false;
      if (v < 0) {
        targetPos = math.max(0.0, targetPos + v);
      } else {
        targetPos =
            math.min(widget.controller.position.maxScrollExtent, targetPos + v);
      }
    });
  }

  Widget wrapAbsorbPointer({required bool pred, required Widget child}) {
    return pred ? AbsorbPointer(child: child) : child;
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
        child: wrapAbsorbPointer(
          pred: widget.smoothScroll || !widget.shouldScroll,
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
            physics: widget.physics,
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
  bool scrollBarScroll = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.offset == targetPos) {
        scrollBarScroll = true;
      }
      if (!widget.smoothScroll || scrollBarScroll) {
        targetPos = widget.controller.offset;
      }
    });
  }

  void updatePos(double v) {
    setState(() {
      scrollBarScroll = false;
      if (v < 0) {
        targetPos = math.max(0.0, targetPos + v);
      } else {
        targetPos =
            math.min(widget.controller.position.maxScrollExtent, targetPos + v);
      }
    });
  }

  Widget wrapAbsorbPointer({required bool pred, required Widget child}) {
    return pred ? AbsorbPointer(child: child) : child;
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
        child: wrapAbsorbPointer(
          pred: widget.smoothScroll || !widget.shouldScroll,
          child: ListView.custom(
            cacheExtent: widget.cacheExtent,
            childrenDelegate: widget.childrenDelegate,
            clipBehavior: widget.clipBehavior,
            controller: widget.controller,
            dragStartBehavior: widget.dragStartBehavior,
            itemExtent: widget.itemExtent,
            keyboardDismissBehavior: widget.keyboardDismissBehavior,
            padding: widget.padding,
            physics: widget.physics,
            primary: widget.primary,
            prototypeItem: widget.prototypeItem,
            restorationId: widget.restorationId,
            reverse: widget.reverse,
            scrollDirection: widget.scrollDirection,
            semanticChildCount: widget.semanticChildCount,
            shrinkWrap: widget.shrinkWrap,
          ),
        ),
      ),
    );
  }
}

double updatePos({
  required ScrollController scrollController,
  required double scrollDelta,
  required double target,
  required bool compensate,
}) {
  final double newTarget = math.min(
    scrollController.position.maxScrollExtent,
    math.max(0.0, target + scrollDelta),
  );
  return newTarget;
}

class _AnimationHandler {
  double targetPos;
  bool isAnimating;
  final bool shouldScroll;
  final bool smoothScroll;
  final ScrollController controller;
  final Duration duration;
  final Curve curve;
  double? delta;
  bool waitingForController = false;
  double targetRaw;

  _AnimationHandler({
    required this.targetPos,
    required this.isAnimating,
    required this.shouldScroll,
    required this.smoothScroll,
    required this.controller,
    required this.duration,
    required this.curve,
  }) : targetRaw = targetPos;

  void setTargetPos(double newPos, [double? option]) {
    if (option != null) {
      // listener
      delta = option;
      waitingForController = true;
      targetRaw = newPos;
    } else {
      // controller
      if (waitingForController) {
        debugPrint("good");
        // compensate after
        waitingForController = false;
        debugPrint("offset : ${controller.offset}");
        debugPrint("delta : $delta");
        controller.jumpTo(delta!);
      }
    }
    targetPos = newPos;
  }

  /// call after targetPos has been set
  void setIsAnimating(bool newIsAnimating) {
    if (newIsAnimating) {
      targetRaw = targetPos;
    }
    isAnimating = newIsAnimating;
    /* if (!isAnimating) return;
    debugPrint(smoothScroll.toString());
    if (shouldScroll &&
        smoothScroll &&
        controller.hasClients &&
        targetPos != controller.offset) {
      debugPrint("here");
      // --- here
      // controller.jumpTo(targetPos); <-- works
      controller.animateTo(targetPos, duration: duration, curve: curve);
    } */
  }
}

enum NotificationType {
  listener,
  controller,
  animation,
}

enum ListState {
  init,
  waitingForController,
  animating,
}

class __AnimationHandler {
  final ScrollController controller;
  DateTime? animationEnd;
  ListState state = ListState.init;
  Duration animationDuration;
  Curve animationCurve;
  double target;

  __AnimationHandler(
      this.controller, this.animationDuration, this.animationCurve)
      : target = controller.initialScrollOffset;

  void send(NotificationType noti, [double? scrollDelta, double? dest]) {
    debugPrint(state.toString());
    debugPrint(noti.toString());
    debugPrint("");
    switch ([state, noti]) {
      case [ListState.init, NotificationType.listener]:
        state = ListState.waitingForController;
        controller.jumpTo(target - scrollDelta!);
        target = dest!;
        break;
      case [ListState.init, NotificationType.controller]:
        state = ListState.init;
        target = controller.offset;
        break;
      case [ListState.init, NotificationType.animation]:
        state = ListState.animating;
        animationEnd = DateTime.now().add(animationDuration);
        controller.jumpTo(target - scrollDelta!);
        target -= scrollDelta;
        target = dest!;
        controller
            .animateTo(
              dest,
              duration: const Duration(seconds: 2),
              curve: animationCurve,
            )
            .then((_) => debugPrint("then"));
        break;

      case [ListState.waitingForController, NotificationType.controller]:
        state = ListState.init;
        break;

      case [ListState.animating, NotificationType.listener]:
        if (DateTime.now().isAfter(animationEnd!)) {
          state = ListState.init;
          send(noti, scrollDelta, dest);
        }
        break;
      case [ListState.animating, NotificationType.controller]:
        if (DateTime.now().isAfter(animationEnd!)) {
          state = ListState.init;
          send(noti, scrollDelta, dest);
        }
        break;
      case [ListState.animating, NotificationType.animation]:
        state = ListState.init;
        send(noti, scrollDelta, dest);
        break;
    }
  }
}
