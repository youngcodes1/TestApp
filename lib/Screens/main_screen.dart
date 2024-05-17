import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Provider/image_provider.dart';
import 'package:test_app/Screens/detail_screen.dart';
import 'package:test_app/Widgets/custom_appbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<ImagesProvider>(context, listen: false).fetchPhotos();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<ImagesProvider>(context, listen: false).fetchPhotos();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImagesProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'MainScreen',
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        centerTitle: true,
      ),
      body: Consumer<ImagesProvider>(
        builder: (context, imagesProvider, _) {
          if (imagesProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (imagesProvider.photos.isEmpty) {
            return const Center(child: Text('No images available'));
          } else {
            return ListView.builder(
              controller: _scrollController,
              itemCount: imagesProvider.photos.length + 1,
              itemBuilder: (context, index) {
                if (index < imagesProvider.photos.length) {
                  final photo = imagesProvider.photos[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(DetailScreen(photo: photo));
                    },
                    child: ListTile(
                      title: Image.network(
                        photo.imageUrl,
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
