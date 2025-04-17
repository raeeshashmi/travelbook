import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelcommunity/utils/helper_functions.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String? name, image;
  void getUserData() async {
    String email = FirebaseAuth.instance.currentUser!.email!;
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    setState(() {
      name = data.docs.first['name'];
      image = data.docs.first['image'];
    });
  }

  File? selectedImage;
  bool isLoading = false;

  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController captionController = TextEditingController();

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> uploadPost() async {
    if (selectedImage == null ||
        placeNameController.text.trim().isEmpty ||
        cityNameController.text.trim().isEmpty ||
        captionController.text.trim().isEmpty) {
      HelperFunctions.customSnackBar(
        context: context,
        text: 'All fields including image are required!',
        bgColor: Colors.red,
        txtColor: Colors.white,
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      String id = DateTime.now().millisecondsSinceEpoch.toString();
      String path = 'uploads/$id';

      await Supabase.instance.client.storage
          .from('images')
          .upload(path, selectedImage!);

      String imageUrl =
          Supabase.instance.client.storage.from('images').getPublicUrl(path);

      await FirebaseFirestore.instance.collection('posts').add({
        'place': placeNameController.text.trim(),
        'city': cityNameController.text.trim(),
        'caption': captionController.text.trim(),
        'imageUrl': imageUrl,
        'timestamp': Timestamp.now(),
        'name': name,
        'image': image,
      });

      setState(() {
        selectedImage = null;
        placeNameController.clear();
        cityNameController.clear();
        captionController.clear();
      });

      HelperFunctions.customSnackBar(
        context: context,
        text: 'Post Added Successfully!',
        bgColor: Colors.green,
        txtColor: Colors.white,
      );
    } catch (e) {
      HelperFunctions.customSnackBar(
        context: context,
        text: 'Error: ${e.toString()}',
        bgColor: Colors.red,
        txtColor: Colors.white,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  InputDecoration customInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    );
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF0F4F8), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HelperFunctions.customAppBar('Add Post', context),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Center(
                        child: GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: selectedImage == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.add_a_photo_outlined,
                                          size: 40, color: Colors.grey),
                                      SizedBox(height: 10),
                                      Text("Upload Image",
                                          style: TextStyle(color: Colors.grey)),
                                    ],
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.file(
                                      selectedImage!,
                                      height: 180,
                                      width: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextField(
                          controller: placeNameController,
                          decoration: customInputDecoration("Place Name"),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextField(
                          controller: cityNameController,
                          decoration: customInputDecoration("City Name"),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextField(
                          controller: captionController,
                          maxLines: 4,
                          decoration: customInputDecoration("Caption"),
                        ),
                      ),
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: isLoading ? null : uploadPost,
                        child: Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6DC8F3), Color(0xFF73A1F9)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  "Post Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
