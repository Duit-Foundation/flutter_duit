part of 'el.dart';

const _typeLookup = <String, int>{
  //leaf elements
  ElementType.text: 0,
  ElementType.elevatedButton: 0,
  //single-child elements
  ElementType.animatedBuilder: 1,
  //multi-child elements
  ElementType.row: 2,
  ElementType.component: 2,
};
