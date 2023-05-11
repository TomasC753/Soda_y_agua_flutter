import 'package:flutter/material.dart';
import 'package:soda_y_agua_flutter/widgets/Navigation/MyDrawer.dart';
import 'package:soda_y_agua_flutter/widgets/my_scaffold.dart';
import 'package:soda_y_agua_flutter/widgets/Navigation/MyNavigationRail.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Dashboard',
      body: Row(
        children: [
          MyNavigationRail(),
        ],
      ),
    );
  }
}
