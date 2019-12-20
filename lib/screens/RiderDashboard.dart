
import 'package:flutter/cupertino.dart';

class RiderDashBoard extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() =>RiderDashboardState();

}
class RiderDashboardState extends State< RiderDashBoard >
{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Rider"),
      ),
    );
  }

}