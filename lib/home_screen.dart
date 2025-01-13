import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gellay/home_provider.dart';
import 'package:gellay/image_mode.dart';
import 'package:gellay/imagephto_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AfterLayoutMixin {
  List<ImageModel> images = [];
  bool isloding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gellray App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        actions: [
          PopupMenuButton(
              itemBuilder: (_) => [
                    PopupMenuItem(
                        onTap: () => SystemNavigator.pop(),
                        child: Text("  EXIST"))
                  ])
        ],
      ),
      body: Builder(builder: (context) {
        if (isloding) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (images.isEmpty) {
          return Center(
            child: Text(" no image "),
          );
        } else {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ImagephtoView(url: images[index].image ?? ""),
                        ),
                      );
                    },
                    child: Image.network(
                      images[index].image ?? "",
                      fit: BoxFit.cover,
                    ),
                  ));
        }
      }),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getimages();
  }

  getimages() async {
    isloding = true;
    setState(() {});
    images = await HomeProvider().getImages();
    await Future.delayed(Duration(seconds: 2));
    isloding = false;
    setState(() {});
  }
}
