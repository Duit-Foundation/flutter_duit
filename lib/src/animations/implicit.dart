import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

abstract class ImplicitAnimatable {
  final Duration duration;
  final Curve curve;
  final ServerAction? onEnd;

  const ImplicitAnimatable({
    required this.duration,
    this.onEnd,
    this.curve = Curves.linear,
  });
}
