import 'package:flutter/material.dart'
    show SliverGridDelegate, SliverChildListDelegate;

typedef SliverGridDelegateBuilder = SliverGridDelegate Function(
    Map<String, dynamic> params);
typedef SliverChildListDelegateBuilder = SliverChildListDelegate Function(
    Map<String, dynamic> params);

typedef SliverGridDelegatesRegistry = Map<String, SliverGridDelegateBuilder>;
typedef SliverChildListDelegateRegistry
    = Map<String, SliverChildListDelegateBuilder>;
