<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A flutter plugin to implement smooth scrolling on desktop and web.

<!--! insérer une vidéo comparant avec et sans -->

## Features

Use this package to scroll smoothly while using a mouse wheel
(usually for web and desktop).

Constructors :

- `SmoothListView(...)` : behave exactly like a classic `ListView(...)`
    except that it makes scrolling with a mouse wheel smoother.
- `SmoothListView.builder(...)` : behave exactly like a classic
    `ListView.builder(...)` except that it makes scrolling with a mouse wheel
    smoother.
- `SmoothListView.adapative(...)` : behave exactly like a classic
    `ListView(...)` except that it allows you to easily switch between
    smooth scroll and classic scroll.
- `SmoothListView.adaptiveBuilder(...)` : behave exactly like a classic
    `ListView.builder(...)` except that it allows you to easily switch between
    smooth scroll and classic scroll.

## Getting started

First, add the package to your `pubspec.yaml` :

```shell
flutter pub add smooth_list_view
```

Then import it inside your Dart code :

```dart
import 'package:smooth_list_view/smooth_list_view.dart';
```

## Usage

Import the package :

```dart
import 'package:smooth_list_view/smooth_list_view.dart';
```

And replace :

```dart
// ...
@override
Widget build(BuildContext context) {
    return ListView(...);
}
// ...
```

With :

```dart
// ...
@override
Widget build(BuildContext context) {
    // You can keep the exact same parameters
    return SmoothListView(...);
}
// ...
```

## Additional information

Feel free to check the Example panel for a richer implementation.

If you encounter any issue feel free to open one on GitHub :)
