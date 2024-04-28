import 'package:flutter/material.dart';
import '../assets.dart';
import '../styles.dart';
import 'title_screen_ui.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  final _finalReceiveLightAmt = 0.7;

  final _finalEmitLightAmt = 0.5;

  int _difficulty = 0;

  void _handleDifficultyPressed(int value) {
    setState(() => _difficulty = value);
  }

  @override
  Widget build(BuildContext context) {
    final orbColor = AppColors.orbColors[_difficulty];
    final emitColor = AppColors.emitColors[_difficulty];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            /// Bg-Base
            Image.asset(AssetPaths.titleBgBase),

            /// Bg-Receive
            _LitImage(
              imgSrc: AssetPaths.titleBgReceive,
              color: orbColor,
              lightAmt: _finalReceiveLightAmt,
            ),

            /// Mg-Base
            _LitImage(
              imgSrc: AssetPaths.titleMgBase,
              color: orbColor,
              lightAmt: _finalReceiveLightAmt,
            ),

            /// Mg-Receive
            _LitImage(
              imgSrc: AssetPaths.titleMgReceive,
              color: orbColor,
              lightAmt: _finalReceiveLightAmt,
            ),

            /// Mg-Emit
            _LitImage(
              imgSrc: AssetPaths.titleMgEmit,
              color: emitColor,
              lightAmt: _finalEmitLightAmt,
            ),

            /// Fg-Rocks
            Image.asset(AssetPaths.titleFgBase),

            /// Fg-Receive
            _LitImage(
              imgSrc: AssetPaths.titleFgReceive,
              color: orbColor,
              lightAmt: _finalReceiveLightAmt,
            ),

            /// Fg-Emit
            _LitImage(
              imgSrc: AssetPaths.titleFgEmit,
              color: emitColor,
              lightAmt: _finalEmitLightAmt,
            ),
            Positioned.fill(
              child: TitleScreenUi(
                difficulty: 0,
                onDifficultyFocused: (newDifficulty) => {},
                onDifficultyPressed: _handleDifficultyPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LitImage extends StatelessWidget {
  const _LitImage({
    required this.color,
    required this.imgSrc,
    required this.lightAmt,
  });

  final Color color;
  final String imgSrc;
  final double lightAmt;
  @override
  Widget build(BuildContext context) {
    final hsl = HSLColor.fromColor(color);
    final lightenedHsl = hsl.withLightness(hsl.lightness * lightAmt).toColor();

    return Image.asset(
      imgSrc,
      color: lightenedHsl,
      colorBlendMode: BlendMode.modulate,
    );
  }
}
