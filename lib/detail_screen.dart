import 'package:bahaya_rokok/master_data.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String code;

  const DetailScreen({Key? key, required this.title, required this.code})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late VideoPlayerController _firstController;
  late Map<String, Object> _currentData;
  late List<String> _videos;
  late List<String> _images;

  @override
  void didChangeDependencies() async {
    _currentData = masterData[widget.code]!;

    _videos = _currentData["videos"] as List<String>;
    _images = _currentData["images"] as List<String>;
    _firstController = VideoPlayerController.asset(_videos[0]);
    await _firstController.initialize();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final firstChewieController =
        ChewieController(videoPlayerController: _firstController);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(_currentData["materi"] as String,
                  textAlign: TextAlign.justify),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Text(
                'Images',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset(
              _images[0],
              width: MediaQuery.of(context).size.width - 32,
              fit: BoxFit.fitWidth,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Text(
                'Videos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            AspectRatio(
                aspectRatio: _firstController.value.aspectRatio,
                child: Chewie(controller: firstChewieController)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstController.dispose();
    super.dispose();
  }
}
