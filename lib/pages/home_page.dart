import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_altruism_assignment/providers/api_service_provider.dart';
import 'package:system_altruism_assignment/providers/selected_image_provider.dart';
import 'package:system_altruism_assignment/widgets/upload_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var apiServiceProvider = Provider.of<ApiServiceProvider>(context);
    var selectedImageProvider = Provider.of<SelectedImageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Systemic Altruism"),
        centerTitle: true,
      ),
      body: Container(
        height: h,
        width: w,
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            selectedImageProvider.selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Image.file(
                      selectedImageProvider.selectedImage!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                : const CircleAvatar(
                    radius: 50.0,
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            UploadWidget(
              onTap: () async {
                await selectedImageProvider.pickedImageFromGallery;
                apiServiceProvider.fetchImages();
              },
              width: w,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                future: null,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong!");
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5),
                      itemCount: apiServiceProvider.currentIndex + 1,
                      itemBuilder: (context, index) {
                        if (index < apiServiceProvider.currentIndex) {
                          // Display already loaded images
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              apiServiceProvider.images[index].thumbnail,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else if (index == apiServiceProvider.currentIndex) {
                          // Display loading indicator
                          if (apiServiceProvider.currentIndex ==
                              apiServiceProvider.images.length) {
                            return const Center(
                                child: Text('No more Images to show, Upload an Image',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),));
                          } else {
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          }
                        } else {
                          // For indices beyond currentIndex, return an empty container
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
