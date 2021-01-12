import 'package:flutter/rendering.dart';

class Incredients {
  Incredients({
    this.image,
    this.position,
  });
  final String image;
  final List<Offset> position;
  bool compare(Incredients ingredient) => ingredient.image == image;
}

final ingredients = <Incredients>[
  Incredients(image: "assets/part1/chili.png", position: [
    Offset(0.2, 0.2),
    Offset(0.6, 0.2),
    Offset(0.4, 0.25),
    Offset(0.5, 0.3),
    Offset(0.4, 0.65),
  ]),
  Incredients(image: "assets/part1/garlic.png", position: [
    Offset(0.2, 0.35),
    Offset(0.65, 0.35),
    Offset(0.3, 0.23),
    Offset(0.5, 0.2),
    Offset(0.3, 0.5),
  ]),
  Incredients(image: "assets/part1/olive.png", position: [
    Offset(0.25, 0.5),
    Offset(0.65, 0.6),
    Offset(0.2, 0.3),
    Offset(0.4, 0.2),
    Offset(0.2, 0.6),
  ]),
  Incredients(image: "assets/part1/onion.png", position: [
    Offset(0.2, 0.65),
    Offset(0.65, 0.3),
    Offset(0.5, 0.25),
    Offset(0.45, 0.35),
    Offset(0.4, 0.45),
  ]),
  Incredients(image: "assets/part1/pea.png", position: [
    Offset(0.2, 0.35),
    Offset(0.65, 0.35),
    Offset(0.3, 0.23),
    Offset(0.5, 0.2),
    Offset(0.3, 0.5),
  ]),
  Incredients(image: "assets/part1/pickle.png", position: [
    Offset(0.2, 0.65),
    Offset(0.65, 0.3),
    Offset(0.25, 0.25),
    Offset(0.45, 0.35),
    Offset(0.4, 0.65),
  ]),
  Incredients(image: "assets/part1/potato.png", position: [
    Offset(0.2, 0.2),
    Offset(0.6, 0.2),
    Offset(0.4, 0.25),
    Offset(0.5, 0.3),
    Offset(0.4, 0.65),
  ]),
];
