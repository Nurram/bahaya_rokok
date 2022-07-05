import 'package:bahaya_rokok/master_data.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DetailScreenTwo extends StatefulWidget {
  final String title;
  final String code;

  const DetailScreenTwo({Key? key, required this.title, required this.code})
      : super(key: key);

  @override
  State<DetailScreenTwo> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreenTwo> {
  late VideoPlayerController _firstController;
  late VideoPlayerController _secondController;
  late ChewieController _firstChewieController;
  late ChewieController _secondChewieController;

  late Map<String, Object> _currentData;
  late List<String> _videos;
  late List<String> _images;

  @override
  void initState() {
    _currentData = masterData[widget.code]!;
    _videos = _currentData["videos"] as List<String>;
    _images = _currentData["images"] as List<String>;

    _buildVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Text(_currentData["materi"] as String, textAlign: TextAlign.justify,),
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
            Image.asset(
              _images[1],
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
            _firstController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _firstController.value.aspectRatio,
                    child: Chewie(controller: _firstChewieController))
                : Container(),
            _secondController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _secondController.value.aspectRatio,
                    child: Chewie(controller: _secondChewieController))
                : Container()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();

    _firstChewieController.dispose();
    _secondChewieController.dispose();
    super.dispose();
  }

  _buildVideo() async {
    _firstController = VideoPlayerController.asset(_videos[0]);
    _secondController = VideoPlayerController.asset(_videos[1]);

    await Future.wait(
        [_firstController.initialize(), _secondController.initialize()]);

    _firstChewieController =
        ChewieController(videoPlayerController: _firstController);
    _secondChewieController =
        ChewieController(videoPlayerController: _secondController);

    setState(() {});
  }
}
