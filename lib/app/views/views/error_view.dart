import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ErrorView extends GetView {
  const ErrorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'ERROR',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
