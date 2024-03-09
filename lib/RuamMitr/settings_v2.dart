import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/avatar.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/RuamMitr/admin.dart';
import 'package:ruam_mitt/RuamMitr/Component/ruammitr_report.dart';
import 'package:ruam_mitt/RuamMitr/Component/client_settings.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsWidgetV2 extends StatefulWidget {
  const SettingsWidgetV2({super.key, required this.reportBoxController});
  final BoxController reportBoxController;

  @override
  State<SettingsWidgetV2> createState() => _SettingsWidgetV2State();
}

class _SettingsWidgetV2State extends State<SettingsWidgetV2> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      physics: const RangeMaintainingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height -
              [size.width * 0.4, 100.0].reduce(min) -
              MediaQuery.of(context).padding.top,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AvatarViewer(size: size),
                      reportToUs(themeProvider, widget.reportBoxController)
                    ],
                  ),
                ),
                const ClientSettingsWidget(),
                // if (profileData['role'] == "User")
                //   Padding(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: size.width * 0.19),
                //     child: InkWell(
                //       onTap: () {},
                //       child: Ink(
                //         width: size.width,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               "Report",
                //               style: theme.textTheme.bodyLarge,
                //             ),
                //             const Icon(Icons.flag)
                //           ],
                //         ),
                //       ),
                //     ),
                //   )
                // else
                //   const SizedBox(),
              ],
            ),
            Column(
              children: [
                if (profileData['role'] == "Admin")
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const AdminPage(),
                        ),
                      );
                    },
                    icon: Image.asset(
                      "assets/images/Ruammitr/admin_page_icon.png",
                      height: size.height * 0.07,
                    ),
                  ),
                Container(
                  width: [size.width * 0.6, 300.0].reduce(min),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, size.width * 0.15),
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      textStyle: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool("isChecked", false);
                      await prefs.setString("password", "");
                      isOnceLogin = true;
                      publicToken = "";
                      profileData = {};
                      if (context.mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginPageRoute,
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
