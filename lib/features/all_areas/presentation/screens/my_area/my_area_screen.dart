import 'package:flutter/material.dart';

import '../../../../../core/presentation/screens/views/views.dart';

class MyAreaScreen extends StatelessWidget {
  static const String routeName = 'my_area_screen';
  const MyAreaScreen({
    super.key,
    required this.typeUserId,
  });
  final int typeUserId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Área $typeUserId'),
      ),
      body: MyAreaView(
        typeUserId: typeUserId,
      ),
    );
  }
}
