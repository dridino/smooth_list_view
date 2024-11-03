library smooth_list_view;

import 'dart:ui';

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
  final ScrollController? controller;
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
  /// the animation, `shouldScroll` used to decide wether this `ListView`
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
  /// the animation, `shouldScroll` used to decide wether this `ListView`
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
  /// the animation, `shouldScroll` used to decide wether this `ListView`
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
      if (!animationHandler.isAnimating ||
          animationHandler.waitingForController) {
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
    return Listener(
      onPointerSignal: (PointerSignalEvent event) {
        if (event is PointerScrollEvent &&
            widget.smoothScroll &&
            widget.shouldScroll) {
          animationHandler.setIsAnimating(true);
          final double newPos =
              bound(animationHandler.targetRaw + event.scrollDelta.dy);
          animationHandler.setTargetPos(newPos, widget.controller.offset);
          setState(() {});
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
      if (!animationHandler.isAnimating ||
          animationHandler.waitingForController) {
        animationHandler.setTargetPos(widget.controller.offset);
      }
    });
  }

  @override
  void didUpdateWidget(covariant _SmoothListViewSeparated oldWidget) {
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
    return Listener(
      onPointerSignal: (PointerSignalEvent event) {
        if (event is PointerScrollEvent &&
            widget.smoothScroll &&
            widget.shouldScroll) {
          animationHandler.setIsAnimating(true);
          final double newPos =
              bound(animationHandler.targetRaw + event.scrollDelta.dy);
          animationHandler.setTargetPos(newPos, widget.controller.offset);
          setState(() {});
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
        physics: widget.physics,
        primary: widget.primary,
        restorationId: widget.restorationId,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        separatorBuilder: widget.separatorBuilder,
        shrinkWrap: widget.shrinkWrap,
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
      if (!animationHandler.isAnimating ||
          animationHandler.waitingForController) {
        animationHandler.setTargetPos(widget.controller.offset);
      }
    });
  }

  @override
  void didUpdateWidget(covariant _SmoothListViewItems oldWidget) {
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
    return Listener(
      onPointerSignal: (PointerSignalEvent event) {
        if (event is PointerScrollEvent &&
            widget.smoothScroll &&
            widget.shouldScroll) {
          animationHandler.setIsAnimating(true);
          final double newPos =
              bound(animationHandler.targetRaw + event.scrollDelta.dy);
          animationHandler.setTargetPos(newPos, widget.controller.offset);
          setState(() {});
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
      if (!animationHandler.isAnimating ||
          animationHandler.waitingForController) {
        animationHandler.setTargetPos(widget.controller.offset);
      }
    });
  }

  @override
  void didUpdateWidget(covariant _SmoothListViewCustom oldWidget) {
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
    return Listener(
      onPointerSignal: (PointerSignalEvent event) {
        if (event is PointerScrollEvent &&
            widget.smoothScroll &&
            widget.shouldScroll) {
          animationHandler.setIsAnimating(true);
          final double newPos =
              bound(animationHandler.targetRaw + event.scrollDelta.dy);
          animationHandler.setTargetPos(newPos, widget.controller.offset);
          setState(() {});
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
        physics: widget.physics,
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
  DateTime? animationStart;

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
      targetPos = newPos;
    } else {
      // controller
      if (waitingForController) {
        // compensate after
        waitingForController = false;
        controller.jumpTo(delta!);
      }
      if (!isAnimating) targetPos = newPos;
    }
  }

  void setIsAnimating(bool newIsAnimating) {
    if (!newIsAnimating) {
      if (animationStart != null) {
        if (animationStart!.add(duration).isAfter(DateTime.now())) {
          return;
        } else {
          isAnimating = newIsAnimating;
        }
      }
    } else {
      animationStart = DateTime.now();
      if (!isAnimating) {
        targetRaw = targetPos;
        isAnimating = newIsAnimating;
      }
    }
  }
}
