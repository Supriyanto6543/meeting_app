import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/custom_color.dart';
import '../../../common/custom_font.dart';
import '../../../common/custom_size.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          title: Text('Order Activity'),
          backgroundColor: Colors.indigo,
          elevation: 0,
        ),
      ),
      body: Container(
        child: Center(
          child: Text('Order Page here', style: CustomFont.fontTitleCard(
              CustomColor.black, CustomSize.f23), textAlign: TextAlign.center,),
        )
      ),
    );
  }
}
