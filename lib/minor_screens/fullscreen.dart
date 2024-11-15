import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FullScreenView extends StatefulWidget {
  final dynamic imagesList;
  const FullScreenView({super.key, required this.imagesList});

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  final PageController _controller = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading:
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(
                ('${index + 1}')+('/')+(widget.imagesList.length.toString()),
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 3, 3, 3),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.5,
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                controller: _controller,
                children: images(),
              ),
            ),
            SizedBox(height: size.height * 0.2, child: imageView())
          ],
        ),
      ),
    );
  }

  Widget imageView() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.imagesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _controller.jumpToPage(index);
            },
            child: Container(
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 4, color: const Color.fromARGB(255, 3, 3, 3)),
                  borderRadius: BorderRadius.circular(1),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Image.network(
                      widget.imagesList[index],
                      fit: BoxFit.cover,
                    ))),
          );
        });
  }

  List<Widget> images() {
    return List.generate(widget.imagesList.length, (index) {
      return InteractiveViewer(
          transformationController: TransformationController(),
          child: Image.network(widget.imagesList[index].toString()));
    });
  }
}
