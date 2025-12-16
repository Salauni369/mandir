
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/darshan_controller.dart';
import '../../../models/live_darshan_model.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/imageuploadwidget.dart';

class EditDarshanPage extends StatefulWidget {
  final DarshanModel darshan;

  const EditDarshanPage({super.key, required this.darshan});

  @override
  State<EditDarshanPage> createState() => _EditDarshanPageState();
}

class _EditDarshanPageState extends State<EditDarshanPage> {
  final controller = Get.find<DarshanController>();
  final formKey = GlobalKey<FormState>();

  late TextEditingController titleCtrl;
  late TextEditingController templeCtrl;
  late TextEditingController linkCtrl;

 // final Rxn<String> webImage = Rxn<String>();
  final Rxn<String> mobile_image = Rxn<String>();

  bool isLive = false;

  @override
  void initState() {
    super.initState();

    titleCtrl = TextEditingController(text: widget.darshan.title);
    //templeCtrl = TextEditingController(text: widget.darshan.templeName);
    linkCtrl = TextEditingController(text: widget.darshan.liveLink);

   // webImage.value = widget.darshan.webImage;
    mobile_image.value = widget.darshan.mobile_image;

    isLive = widget.darshan.isLive;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.hinduBase,
        title: const Text("Edit Live Darshan",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Switch(
            value: isLive,
            onChanged: (v) => setState(() => isLive = v),
            activeColor: Colors.white,
          ),
        ],
      ),

      // ---------------- FIXED BUTTON (Correct Place) ----------------
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         // Divider(height: 0.5, color: Colors.grey), // Divider added correctly
          Container(
            padding:  EdgeInsets.all(16),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.hinduBase,
                  padding:  EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final updated = widget.darshan.copyWith(
                      title: titleCtrl.text.trim(),
                      liveLink: linkCtrl.text.trim(),
                      mobile_image: mobile_image.value,
                      status: isLive ? "ACTIVE" : "INACTIVE",
                    );



                    // controller.updateDarshan(updated);
                    // Get.snackbar("Success", "Darshan Updated Successfully");
                    // Get.back();
                  }
                },
                child: const Text("Update",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),

      // ---------------- BODY SCROLL CONTENT ----------------
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ---------------- RICHTEXT BOX ----------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: const Color(0xFFFFF1E9),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Mobile Image\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text:
                        "Supported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ---------------- IMAGE UPLOAD SECTION ----------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE7D6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // ImageUploadWidget(
                    //   initialImage: webImage.value,
                    //   onPicked: (path) => webImage.value = path,
                    //   showInfo: false,
                    // ),
                    const SizedBox(height: 20),
                    // ImageUploadWidget(
                    //   initialImageWidget: mobile_image.value != null &&
                    //       mobile_image.value!.startsWith("http")
                    //       ? CachedNetworkImage(
                    //     imageUrl: mobile_image.value!,
                    //     fit: BoxFit.cover,
                    //     placeholder: (_, __) =>
                    //     const Center(child: CircularProgressIndicator()),
                    //     errorWidget: (_, __, ___) =>
                    //     const Icon(Icons.broken_image, size: 40),
                    //   )
                    //       : null,
                    //   initialImage: mobile_image.value,
                    //   onPicked: (path) => mobile_image.value = path,
                    //   showInfo: false,
                    // ),
                    ImageUploadWidget(
                      initialImage: mobile_image.value,
                      onPicked: (path) => mobile_image.value = path,
                      showInfo: false,
                    ),


                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ---------------- FORM FIELDS ----------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // _label("Mandir *"),
                    // _textbox(templeCtrl),

                    const SizedBox(height: 20),

                    _label("Title *"),
                    _textbox(titleCtrl, maxLines: 2),

                    const SizedBox(height: 20),

                    _label("Live Darshan Link *"),
                    _textbox(linkCtrl),
                  ],
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _textbox(TextEditingController c, {int maxLines = 1}) {
    return TextFormField(
      controller: c,
      maxLines: maxLines,
      validator: (v) => v!.trim().isEmpty ? "Required" : null,
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}





