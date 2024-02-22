import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class WProgress extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final AudioPlayer player;

  const WProgress(
      {super.key,
      required this.duration,
      required this.position,
      required this.player});

  @override
  State<WProgress> createState() => _WProgressState();
}

class _WProgressState extends State<WProgress> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: const Color(0xFFF0B418),
          inactiveTrackColor: Colors.white,
          trackShape: CustomTrackShape(),
          trackHeight: 24.0,
          thumbColor: Colors.blue,
          thumbShape: const CustomThumbShape(),
          overlayColor: const Color(0xFFF0B418),
          rangeTickMarkShape: const RoundRangeSliderTickMarkShape(tickMarkRadius: 8.0),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 8.0),
        ),
        child: Slider(
          value: widget.position.inSeconds.toDouble(),
          onChanged: (newValue) async {
            await widget.player.seek(Duration(seconds: newValue.toInt()));
            setState(() {});
          },
          min: 0,
          max: widget.duration.inSeconds.toDouble(),
        ),
      ),
    );
  }
}
// Padding(
//       padding: const EdgeInsets.only(top: 8, bottom: 24),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: SizedBox.fromSize(
//           size: const Size(double.infinity, 24),
//           child: Stack(
//             children: [
//               const LinearProgressIndicator(
//                 value: 1.0,
//                 valueColor: AlwaysStoppedAnimation(Colors.red),
//               ),
//               LinearProgressIndicator(
//                 minHeight: 24,
//                 value: position.inMilliseconds > 0
//                     ? position.inMilliseconds.toDouble() /
//                         duration.inMilliseconds.toDouble()
//                     : 0.0,
//                 valueColor: const AlwaysStoppedAnimation(
//                   Color(0xFFF0B418),
//                 ),
//                 borderRadius: BorderRadius.circular(8),
//                 backgroundColor: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect(
      {required RenderBox parentBox,
      Offset offset = Offset.zero,
      required SliderThemeData sliderTheme,
      bool isEnabled = false,
      bool isDiscrete = false}) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx + 10;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 20;

    return Rect.fromPoints(
      Offset(trackLeft, trackTop),
      Offset(trackLeft + trackWidth, trackTop + trackHeight),
    );
  }
}

class CustomThumbShape extends RoundSliderThumbShape {
  const CustomThumbShape({
    double thumbRadius = 0.0,
    bool isEnabled = true,
  }) : super(
          enabledThumbRadius: thumbRadius,
          disabledThumbRadius: thumbRadius,
        );

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }
}
