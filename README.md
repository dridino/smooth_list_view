A flutter plugin to implement smooth scrolling on desktop and web.

## Comparison

### Without

![Alt](assets/without.gif "without the package")

### With

![Alt](assets/with.gif "with the package")

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

### ListView

Replace :

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

### ListView.builder()

Replace :

```dart
// ...
@override
Widget build(BuildContext context) {
    return ListView.builder(...);
}
// ...
```

With :

```dart
// ...
@override
Widget build(BuildContext context) {
    // You can keep the exact same parameters
    return SmoothListView.builder(...);
}
// ...
```

### ListView.separated()

Replace :

```dart
// ...
@override
Widget build(BuildContext context) {
    return ListView.separated(...);
}
// ...
```

With :

```dart
// ...
@override
Widget build(BuildContext context) {
    // You can keep the exact same parameters
    return SmoothListView.separated(...);
}
// ...
```

### ListView.custom()

Replace :

```dart
// ...
@override
Widget build(BuildContext context) {
    return ListView.custom(...);
}
// ...
```

With :

```dart
// ...
@override
Widget build(BuildContext context) {
    // You can keep the exact same parameters
    return SmoothListView.custom(...);
}
// ...
```

## Additional information

Feel free to check the Example panel for a richer implementation.

If you encounter any issue feel free to open one on GitHub :)
