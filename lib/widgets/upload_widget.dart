import 'package:flutter/material.dart';

class UploadWidget extends StatelessWidget {
  void Function()? onTap;
  final double width;

  UploadWidget({super.key,required this.onTap, required this.width,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width / 2,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              colors: [Colors.blue, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: AlignmentDirectional.bottomEnd),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 1.0,
              blurRadius: 2.0,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.upload,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Upload Image',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
