import 'package:flutter/material.dart';
import 'package:soda_y_agua_flutter/widgets/MyDrawer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: MyDrawer(),
      ),
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
    );
  }
}
