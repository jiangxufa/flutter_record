import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class BezierMatrix4Tween extends Matrix4Tween {
  BezierMatrix4Tween({Matrix4 begin, Matrix4 end})
      : super(begin: begin, end: end);

  @override
  Matrix4 lerp(double t) {
    assert(begin != null);
    assert(end != null);
    final Vector3 beginTranslation = Vector3.zero();
    final Vector3 endTranslation = Vector3.zero();
    final Quaternion beginRotation = Quaternion.identity();
    final Quaternion endRotation = Quaternion.identity();
    final Vector3 beginScale = Vector3.zero();
    final Vector3 endScale = Vector3.zero();
    begin.decompose(beginTranslation, beginRotation, beginScale);
    end.decompose(endTranslation, endRotation, endScale);
    final Vector3 lerpTranslation =
    _caculate(beginTranslation, endTranslation, t);
    // TODO(alangardner): Implement slerp for constant rotation
    final Quaternion lerpRotation =
    (beginRotation.scaled(1.0 - t) + endRotation.scaled(t)).normalized();
    final Vector3 lerpScale = beginScale * (1.0 - t) + endScale * t;
    return Matrix4.compose(lerpTranslation, lerpRotation, lerpScale);
  }

  Vector3 _caculate(
      Vector3 beginTranslation, Vector3 endTranslation, double t) {
    Vector3 controllPoint = Vector3((beginTranslation.x + endTranslation.x) / 2,
        (beginTranslation.y - 100), 0);
    double x = ((1 - t) * (1 - t) * beginTranslation.x +
        2 * t * (1 - t) * controllPoint.x +
        t * t * endTranslation.x);
    double y = ((1 - t) * (1 - t) * beginTranslation.y +
        2 * t * (1 - t) * controllPoint.y +
        t * t * endTranslation.y);
    return Vector3(x, y, 0);
  }
}
