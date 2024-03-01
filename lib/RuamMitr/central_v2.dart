import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/RuamMitr/home_v2.dart';
import 'package:ruam_mitt/RuamMitr/profile_v2.dart';
import 'package:ruam_mitt/RuamMitr/settings_v2.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:http/http.dart' as http;

class HomePageV2 extends StatefulWidget {
  const HomePageV2({super.key});

  @override
  State<HomePageV2> createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  int pageIndex = 1;
  PageController pageController = PageController(initialPage: 1);
  GlobalKey<FormState> reportKey = GlobalKey();
  GlobalKey<FormFieldState> appSelectKey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController explainationController = TextEditingController();
  TextEditingController imageSelectionController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode explainationFocusNode = FocusNode();

  Future<File?> getImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    //TO convert Xfile into file
    File file = File(image.path);
    //print(‘Image picked’);
    return file;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("Home Ruammitr InitState");
    Uri uri = Uri.parse("$api$userDataRequestRoute");
    setState(() {});
    http.get(uri, headers: {"Authorization": "Bearer $publicToken"}).then(
        (http.Response res) {
      profileData = jsonDecode(res.body);

      setState(() {});
      // print("Requested Data : ${profileData}");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    ThemeData theme = themes.themeFrom("RuamMitr")!.themeData;
    // ThemeData theme = Theme.of(context);
    BoxController reportBoxController = BoxController();
    // String avatarTextBackgroundColorString = theme.colorScheme.primaryContainer
    //     .toString()
    //     .replaceAll("Color(", "")
    //     .replaceAll(")", "")+
    //     .substring(4);
    // String avatarTextColorString = theme.colorScheme.onPrimaryContainer
    //     .toString()
    //     .replaceAll("Color(", "")
    //     .replaceAll(")", "")
    //     .substring(4);
    var nowParam = DateFormat('yyyyddMMHHmm').format(DateTime.now());
    if (profileData['profile'] != null) {
      profileData['imgPath'] = "${profileData['profile']}#$nowParam";
    } else {
      profileData['imgPath'] =
          "https://api.multiavatar.com/${(profileData['fullname'] ?? "").replaceAll(" ", "+")}.png";
    }
    // profileData['imgPath'] = "${profileData['profile']}" ??
    //     // "https://ui-avatars.com/api/?background=$avatarTextBackgroundColorString&color=$avatarTextColorString&size=512&name=${profileData['fullname'].replaceAll(" ", "+")}";
    //     "https://api.multiavatar.com/${(profileData['fullname'] ?? "").replaceAll(" ", "+")}.png";

    return Container(
      decoration: ruamMitrBackgroundGradient(themes),
      child: Theme(
        data: theme,
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: BottomBarDoubleBullet(
              color: theme.colorScheme.primary,
              backgroundColor: theme.colorScheme.primaryContainer,
              selectedIndex: pageIndex,
              items: [
                BottomBarItem(iconData: Icons.person),
                BottomBarItem(iconData: Icons.home),
                BottomBarItem(iconData: Icons.settings),
              ],
              onSelect: (index) {
                pageController.animateToPage(
                  index,
                  duration: const Duration(seconds: 1),
                  curve: const Tanh(),
                );
              },
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (pageChanged) {
                        setState(() => pageIndex = pageChanged);
                      },
                      children: [
                        profileData['fullname'] == null
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    Divider(),
                                    Text("Loading user data"),
                                  ],
                                ),
                              )
                            : const ProfileWidgetV2(),
                        profileData['fullname'] == null
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    Divider(),
                                    Text("Loading user data"),
                                  ],
                                ),
                              )
                            : HomeWidgetV2(
                                reportBoxController: reportBoxController),
                        SettingsWidgetV2(
                            reportBoxController: reportBoxController)
                      ],
                    ),
                  ),
                  SlidingBox(
                    onBoxClose: () {
                      reportKey.currentState?.reset();
                    },
                    draggableIcon: Icons.keyboard_arrow_down_rounded,
                    controller: reportBoxController,
                    collapsed: true,
                    draggable: false,
                    draggableIconVisible: true,
                    minHeight: 0,
                    maxHeight: size.height * 0.6,
                    body: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: size.width,
                      child: Form(
                        // onChanged: () {
                        //   print("something change in the form");
                        // },
                        key: reportKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Report",
                                      style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.fontSize,
                                          fontFamily:
                                              GoogleFonts.getFont("Inter")
                                                  .fontFamily,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Center(
                                      child: IconButton(
                                        onPressed: () {
                                          if (titleController.text
                                                  .trim()
                                                  .isNotEmpty ||
                                              explainationController.text
                                                  .trim()
                                                  .isNotEmpty ||
                                              appSelectKey
                                                      .currentState!.value !=
                                                  null ||
                                              imageSelectionController
                                                  .text.isNotEmpty) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return discardReportConfirm(
                                                      theme, size, context,
                                                      onAnswer: (isConfirm) {
                                                    if (isConfirm) {
                                                      if (explainationFocusNode
                                                          .hasFocus) {
                                                        explainationFocusNode
                                                            .unfocus();
                                                      }
                                                      if (titleFocusNode
                                                          .hasFocus) {
                                                        titleFocusNode
                                                            .unfocus();
                                                      }
                                                      reportKey.currentState
                                                          ?.reset();
                                                      imageSelectionController
                                                          .clear();
                                                      titleController.clear();
                                                      explainationController
                                                          .clear();
                                                      appSelectKey.currentState
                                                          ?.reset();
                                                      reportBoxController
                                                          .closeBox();
                                                      Navigator.pop(context);
                                                    }
                                                  });
                                                });
                                          } else {
                                            if (explainationFocusNode
                                                .hasFocus) {
                                              explainationFocusNode.unfocus();
                                            }
                                            if (titleFocusNode.hasFocus) {
                                              titleFocusNode.unfocus();
                                            }
                                            reportKey.currentState?.reset();
                                            imageSelectionController.clear();
                                            titleController.clear();
                                            explainationController.clear();
                                            appSelectKey.currentState?.reset();
                                            reportBoxController.closeBox();
                                          }
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              "Title",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily:
                                    GoogleFonts.getFont("Inter").fontFamily,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              maxLength: 30,
                              focusNode: titleFocusNode,
                              controller: titleController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: theme.colorScheme.background,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                prefixIcon: const Icon(Icons.title),
                                counterText: "",
                                suffixIcon: titleController.text.isNotEmpty
                                    ? GestureDetector(
                                        onTap: titleController.clear,
                                        child: const Icon(Icons.clear))
                                    : null,
                                hintText: "Title",
                              ),
                              validator: (value) {
                                if ((value ?? "").isEmpty) {
                                  return "Report must have topic";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                reportKey.currentState!.validate();
                                setState(() {});
                              },
                            ),
                            Text(
                              "App",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily:
                                    GoogleFonts.getFont("Inter").fontFamily,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            DropdownButtonFormField(
                              key: appSelectKey,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: theme.colorScheme.background,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                prefixIcon: const Icon(Icons.warning),
                                hintText: "App",
                              ),
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              items: const [
                                DropdownMenuItem(
                                  value: "Ruammitr",
                                  child: Text("Ruammitr"),
                                ),
                                DropdownMenuItem(
                                  value: "Dekhor",
                                  child: Text("Tuachuy Dekhor"),
                                ),
                                DropdownMenuItem(
                                  value: "Restroom",
                                  child: Text("Restroom Rover"),
                                ),
                                DropdownMenuItem(
                                  value: "Bin",
                                  child: Text("Pin The Bin"),
                                ),
                                DropdownMenuItem(
                                  value: "Dinodengzz",
                                  child: Text("Dinodengzz"),
                                ),
                              ],
                              validator: (value) {
                                if ((value ?? "").isEmpty) {
                                  return "Please select app to report";
                                }
                                return null;
                              },
                              onChanged: (item) {
                                reportKey.currentState!.validate();
                              },
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              "Explaniation",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily:
                                    GoogleFonts.getFont("Inter").fontFamily,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              focusNode: explainationFocusNode,
                              controller: explainationController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: theme.colorScheme.background,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                              validator: (value) {
                                if ((value ?? "").isEmpty) {
                                  return "Please explain about the report";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                reportKey.currentState!.validate();
                              },
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              "Upload Photo (Not Required)",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily:
                                    GoogleFonts.getFont("Inter").fontFamily,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              maxLines: 1,
                              readOnly: true,
                              controller: imageSelectionController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.upload),
                                filled: true,
                                fillColor: theme.colorScheme.background,
                                hintText: "Upload Your Screenshot",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                              onTap: () async {
                                // print("Want to upload report picture");
                                File? imageSelected = await getImage();
                                if (imageSelected == null) {
                                } else {
                                  imageSelectionController.text =
                                      imageSelected.path.split("/").last;
                                }
                              },
                            ),
                            SizedBox(height: size.height * 0.025),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  textStyle: TextStyle(
                                    color: theme.colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  foregroundColor: theme.colorScheme.onPrimary,
                                ),
                                child: const Text("Send"),
                                onPressed: () {
                                  if (reportKey.currentState!.validate()) {}
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  AlertDialog discardReportConfirm(
      ThemeData theme, Size size, BuildContext context,
      {required void onAnswer(bool isConfirm)}) {
    return AlertDialog(
      backgroundColor: theme.colorScheme.onPrimary,
      surfaceTintColor: theme.colorScheme.onPrimary,
      title: const Text("Discard report?"),
      actions: [
        InkWell(
          child: Ink(
              width: size.width * 0.2,
              height: size.width * 0.2 * 0.5,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                  child: Text("No",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )))),
          onTap: () {
            onAnswer(false);
          },
        ),
        InkWell(
          child: Ink(
              width: size.width * 0.2,
              height: size.width * 0.2 * 0.8,
              decoration: BoxDecoration(
                // color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text("Yes",
                      style: TextStyle(
                        color: theme.colorScheme.onBackground,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )))),
          onTap: () {
            onAnswer(true);
          },
        ),
      ],
    );
  }
}

class Tanh extends Curve {
  final double count;

  const Tanh({this.count = 3});

  // t = x
  @override
  double transformInternal(double t) {
    t *= 3.5;
    var val = (exp(t) - exp(-t)) / (exp(t) + exp(-t));
    return val; //f(x)
  }
}
