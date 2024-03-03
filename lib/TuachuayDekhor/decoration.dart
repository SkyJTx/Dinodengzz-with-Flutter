import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/blog_box.dart';
import 'package:ruam_mitt/TuachuayDekhor/Component/navbar.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TuachuayDekhorDecorationPage extends StatefulWidget {
  const TuachuayDekhorDecorationPage({super.key});

  @override
  State<TuachuayDekhorDecorationPage> createState() =>
      _TuachuayDekhorDecorationPageState();
}

class _TuachuayDekhorDecorationPageState
    extends State<TuachuayDekhorDecorationPage> {
  final decurl = Uri.parse("$api$dekhorPosttodecorationRoute");
  var blog_dec = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> posttodecoration() async {
    var response = await http.get(
      decurl,
    );
    if (response.statusCode == 200) {
      setState(() {
        blog_dec = jsonDecode(response.body);
        print(blog_dec);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _loadDetail() async {
    setState(() {
      isLoading = true;
    });
    await posttodecoration();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CustomThemes theme =
        ThemesPortal.appThemeFromContext(context, "TuachuayDekhor")!;
    Map<String, Color> customColors = theme.customColors;

    return Scaffold(
      backgroundColor: customColors["background"]!,
      body: SafeArea(
        child: Stack(
          children: [
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: customColors["main"]!,
                    ),
                  )
                : SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: size.height -
                              [size.width * 0.4, 100.0].reduce(min) -
                              MediaQuery.of(context).padding.top),
                      child: Column(
                        children: [
                          Container(
                            height: 235,
                            width: size.width,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                opacity: 0.3,
                                image: AssetImage(
                                    "assets/images/Background/TuachuayDekhor_Decoration.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 120,
                                ),
                                Text(
                                  "DECORATION",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: customColors["onContainer"]!
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: customColors["main"]!,
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.02,
                              left: size.width * 0.04,
                            ),
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_outlined,
                                    color: customColors["main"]!,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Back",
                                    style:
                                        TextStyle(color: customColors["main"]!),
                                  ),
                                ],
                              ),
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: size.width * 0.05,
                                left: size.width * 0.04,
                                right: size.width * 0.04,
                                top: size.width * 0.05),
                            child: MasonryGridView.builder(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              itemCount: blog_dec.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) => BlogBox(
                                title: blog_dec[index]['title'],
                                name: blog_dec[index]['user']['fullname'],
                                category: blog_dec[index]['category'],
                                like: blog_dec[index]['save'] ?? "0",
                                image: NetworkImage(
                                  blog_dec[index]['image_link'],
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    tuachuayDekhorPageRoute['blog']!,
                                    arguments: blog_dec[index]['id_post'],
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            const NavbarTuachuayDekhor(),
          ],
        ),
      ),
    );
  }
}
