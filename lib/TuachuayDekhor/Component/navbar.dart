import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/search_box.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'dart:ui';
// import 'package:ruam_mitt/RuamMitr/Component/home_v2/central_v2.dart';

class NavbarTuachuayDekhor extends StatelessWidget {
  const NavbarTuachuayDekhor({
    super.key,
    this.username,
    this.avatarUrl,
  });
  final String? username;
  final String? avatarUrl;

  Widget getAvatar(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.white.withOpacity(0.5),
      backgroundImage: NetworkImage(profileData['imgPath']),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = ThemesPortal.getCurrent(context);
    CustomThemes theme =
        ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = theme.customColors;
    const double navbarHeight = 100;
    const double paddingSize = 30;

    return Container(
      padding: const EdgeInsets.all(paddingSize * 0.5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            customColors["background"]!,
            customColors["background"]!.withOpacity(0),
          ],
        ),
      ),
      height: navbarHeight,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  tuachuayDekhorPageRoute["home"]!,
                );
              },
              child: Image(
                image: AssetImage(
                  "assets/images/Logo/TuachuayDekhor_${themeProvider.isDarkMode ? "Dark" : "Light"}.png",
                ),
              ),
            ),
          ),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: TuachuaySearchBox(),
            ),
          ),
          RawMaterialButton(
            shape: const CircleBorder(),
            onPressed: () {
              showMenu(
                context: context,
                color: customColors["container"]!,
                surfaceTintColor: Colors.white,
                position: RelativeRect.fromLTRB(
                  size.width,
                  navbarHeight + paddingSize * 0.5,
                  0,
                  0,
                ),
                items: [
                  if (profileData['role'] == "Admin")
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.admin_panel_settings,
                            color: customColors["onContainer"]!,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Admin",
                            style: TextStyle(
                              color: customColors["onContainer"]!,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, tuachuayDekhorPageRoute["admin"]!);
                      },
                    ),
                  if (profileData['role'] == "User")
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: customColors["onContainer"]!,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: customColors["onContainer"]!,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, tuachuayDekhorPageRoute["profile"]!);
                      },
                    ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: customColors["onContainer"]!,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "RuamMitr",
                          style: TextStyle(
                            color: customColors["onContainer"]!,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        ruamMitrPageRoute["home"]!,
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              );
            },
            child: getAvatar(context),
          ),
        ],
      ),
    );
  }
}
