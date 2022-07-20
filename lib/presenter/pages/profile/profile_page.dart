import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/custom_about.dart';
import '../../../common/custom_color.dart';
import '../../../common/custom_space.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          title: Text('My Account'),
          backgroundColor: Colors.indigo,
          elevation: 0,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            Text('Impack Pratama – with its entrepreneurial spirit and commitment to enhancing peoples lifestyles with innovative products, has established itself as a leader in the Indonesian plastic industry.', style: TextStyle(
                color: CustomColor.black, fontSize: 17
            ),),
            CustomSpace().sizedBox(),
            CustomAbout().aboutPage(
              Icons.phone,
              "Phone",
              "(021) 21882099",
                  ()=> {},
            ),
            CustomSpace().sizedBox(),
            CustomAbout().aboutPage(
              Icons.email,
              "Email",
              "email here",
                  ()=> {},
            ),
            CustomSpace().sizedBox(),
            CustomAbout().aboutPage(
              Icons.insert_chart_outlined,
              "Instagram",
              "PT. Impack Pratama Industri Tbk",
                  ()=> {},
            ),
            CustomSpace().sizedBox(),
            CustomAbout().aboutPage(
              Icons.facebook,
              "Facebook",
              "PT. Impack Pratama Industri Tbk",
                  ()=> {},
            ),
            CustomSpace().sizedBox(),
            CustomAbout().aboutPage(
              Icons.wordpress_outlined,
              "Impack Pratama",
              "http://www.impack-pratama.com/",
                  ()=> {},
            ),
          ],
        ),
      )
    );
  }
}
