import 'package:flutter/material.dart' show SliverGridDelegate;

typedef SliverGridDelegateBuilder = SliverGridDelegate Function(
  Map<String, dynamic> params,
);
// typedef SliverChildDelegateBuilder = SliverChildDelegate Function(
//   Map<String, dynamic> params,
// );

typedef SliverGridDelegatesRegistry = Map<String, SliverGridDelegateBuilder>;
// typedef SliverChildListDelegateRegistry
//     = Map<String, SliverChildDelegateBuilder>;
