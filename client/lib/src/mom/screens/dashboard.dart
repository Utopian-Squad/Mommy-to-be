import 'package:client/src/mom/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  static const routeName = "/dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
      ),
      drawer: NavigationDrawerWidget(),
      body: Center(
        child: Text("Dashboard",
            style: GoogleFonts.pacifico(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Colors.purple)),
      ),
    );
  }
}
