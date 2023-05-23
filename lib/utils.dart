import 'dart:math' as math;

(double, bool) newPos(
    double v, bool shouldAnimate, double targetPos, double maxVal,
    {bool updateAnimate = true}) {
  if (!shouldAnimate && updateAnimate) shouldAnimate = true;
  if (v < 0) {
    targetPos = math.max(0.0, targetPos + v);
  } else {
    targetPos = math.min(maxVal, targetPos + v);
  }
  return (targetPos, shouldAnimate);
}
