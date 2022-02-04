import 'package:one_page/app/text_styles.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:webviewx/webviewx.dart';
import 'package:flutter_next/flutter_next.dart';

class VideoPlayer extends StatelessWidget {
  final String? url;
  const VideoPlayer({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _videoPlayer(context);
  }

  Widget _videoPlayer(BuildContext context) {
    bool isVideoAvailable = (UniversalPlatform.isAndroid ||
        UniversalPlatform.isWeb ||
        UniversalPlatform.isIOS);
    return isVideoAvailable
        ? _webVideo(context).container(const EdgeInsets.only(top: 20))
        : Center(
            child: Text(
              "Video player is not supported\nfor this platform",
              style: SectionTitle.h2(context).copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          );
  }

  Widget _webVideo(BuildContext context) {
    String html = '''
  <iframe width="${context.width - 80}" height="${context.height - 80}" src="https://www.youtube.com/embed/4pGqm9l3wd8" title="Will of D" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    ''';
    return WebViewX(
      initialSourceType: SourceType.html,
      width: context.width,
      height: context.height,
      initialContent: html,
    );
  }
}
