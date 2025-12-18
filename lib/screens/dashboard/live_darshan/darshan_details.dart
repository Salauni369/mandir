import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/live_darshan_model.dart';
import 'edit_darshan.dart';

class DarshanDetailPage extends StatefulWidget {
  final DarshanModel darshan;

  const DarshanDetailPage({super.key, required this.darshan});

  @override
  State<DarshanDetailPage> createState() => _DarshanDetailPageState();
}

class _DarshanDetailPageState extends State<DarshanDetailPage> {
  late YoutubePlayerController _ytController;

  bool playVideo = false;
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();

    final videoId =
        YoutubePlayer.convertUrlToId(widget.darshan.liveLink) ?? "";

    _ytController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        forceHD: true,
      ),
    );

    _ytController.addListener(() {
      final full = _ytController.value.isFullScreen;
      if (full != isFullScreen) {
        setState(() {
          isFullScreen = full;
        });
      }
    });
  }

  @override
  void dispose() {
    _ytController.dispose();
    super.dispose();
  }

  String safeImageUrl(String url) {
    if (url.isEmpty) return url;

    if (url.contains("res.cloudinary.com") && !url.contains("f_auto")) {
      return url.replaceFirst(
        "/upload/",
        "/upload/f_auto,q_auto/",
      );
    }
    return url;
  }

  Future<void> _openLink(String url) async {
    if (url.isEmpty) return;

    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not open link");
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.darshan;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isFullScreen
          ? null
          : AppBar(
        backgroundColor: const Color(0xFFFF7722),
        title: const Text(
          "Live Darshan Details",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: isFullScreen
          ? YoutubePlayer(
        controller: _ytController,
        showVideoProgressIndicator: true,
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ---------- VIDEO ----------
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: playVideo
                    ? YoutubePlayer(
                  controller: _ytController,
                  showVideoProgressIndicator: true,
                )
                    : GestureDetector(
                  onTap: () =>
                      setState(() => playVideo = true),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                        "https://img.youtube.com/vi/${_ytController.initialVideoId}/hqdefault.jpg",
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                        const Center(
                          child:
                          CircularProgressIndicator(),
                        ),
                        errorWidget: (_, __, ___) =>
                            Container(
                              height: 200,
                              color:
                              Colors.grey.shade300,
                              child: const Icon(
                                Icons.broken_image,
                              ),
                            ),
                      ),
                      const Icon(
                        Icons.play_circle_fill,
                        size: 60,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// ---------- LINK ----------
            InkWell(
              onTap: () => _openLink(model.liveLink),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      model.liveLink,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.open_in_new, size: 18),
                ],
              ),
            ),

            const SizedBox(height: 11),

            /// ---------- TITLE ----------
            Text(
              model.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),

            /// ---------- MOBILE IMAGE ----------
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: model.mobile_image == null
                  ? Container(
                height: 220,
                color: Colors.grey.shade300,
                child:
                const Icon(Icons.image, size: 40),
              )
                  : model.mobile_image!.startsWith("http")
                  ? CachedNetworkImage(
                imageUrl: safeImageUrl(
                    model.mobile_image!),
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                const Center(
                  child:
                  CircularProgressIndicator(),
                ),
                errorWidget: (_, __, ___) =>
                    Container(
                      color:
                      Colors.grey.shade300,
                      child: const Icon(
                        Icons.broken_image,
                      ),
                    ),
              )
                  : Image.file(
                File(model.mobile_image!),
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),

      bottomNavigationBar: isFullScreen
          ? null
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  foregroundColor: Colors.black,
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(
                      vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(40),
                  ),
                ),
                onPressed: () => Get.back(),
                child: const Text(
                  "Back",
                  style: TextStyle(
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(40),
                  ),
                  elevation: 0,
                ),
                onPressed: () => Get.to(
                      () =>
                      EditDarshanPage(darshan: model),
                ),
                child: const Text(
                  "Edit",
                  style: TextStyle(
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
