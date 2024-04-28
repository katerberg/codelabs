import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
import 'package:gap/gap.dart';

import '../assets.dart';
import '../common/ui_scaler.dart';
import '../styles.dart';

class TitleScreenUi extends StatelessWidget {
  const TitleScreenUi({
    super.key,
    required this.difficulty,
    required this.onDifficultyPressed,
    required this.onDifficultyFocused,
  });
  final int difficulty;
  final void Function(int difficulty) onDifficultyPressed;
  final void Function(int? difficulty) onDifficultyFocused;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
      child: Stack(children: [
        const TopLeft(
          child: UiScaler(
            alignment: Alignment.topLeft,
            child: _TitleScreenText(),
          ),
        ),
        BottomLeft(
          child: UiScaler(
            alignment: Alignment.bottomLeft,
            child: _DifficultyButtons(
                difficulty: difficulty,
                onDifficultyPressed: onDifficultyPressed,
                onDifficultyFocused: onDifficultyFocused),
          ),
        )
      ]),
    );
  }
}

class _TitleScreenText extends StatelessWidget {
  const _TitleScreenText();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.translate(
              offset: Offset(-(TextStyles.h1.letterSpacing! * .5), 0),
              child: Text('OUTPOST', style: TextStyles.h1),
            ),
            Image.asset(AssetPaths.titleSelectedLeft, height: 65),
            Text('7', style: TextStyles.h2),
            Image.asset(AssetPaths.titleSelectedRight, height: 65),
          ],
        ),
        Text('INTO THE UNKNOWN', style: TextStyles.h3),
      ],
    );
  }
}

class _DifficultyButtons extends StatelessWidget {
  const _DifficultyButtons({
    required this.difficulty,
    required this.onDifficultyPressed,
    required this.onDifficultyFocused,
  });
  final int difficulty;
  final void Function(int difficulty) onDifficultyPressed;
  final void Function(int? difficulty) onDifficultyFocused;

  @override
  Widget build(BuildContext context) {
    var levels = ['Easy', 'Normal', 'Hard'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...levels.map((level) {
          var index = levels.indexOf(level);
          return _DifficultyButton(
              selected: difficulty == index,
              label: level,
              onHover: (over) => onDifficultyFocused(over ? index : null),
              onPressed: () => onDifficultyPressed(index));
        }),
        const Gap(20),
      ],
    );
  }
}

class _DifficultyButton extends StatelessWidget {
  const _DifficultyButton({
    required this.selected,
    required this.onPressed,
    required this.onHover,
    required this.label,
  });
  final String label;
  final bool selected;
  final VoidCallback onPressed;
  final void Function(bool hasFocus) onHover;

  @override
  Widget build(BuildContext context) {
    return FocusableControlBuilder(
        onPressed: onPressed,
        onHoverChanged: (_, state) => onHover.call(state.isHovered),
        builder: (_, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 250,
              height: 60,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D1FF).withOpacity(0.1),
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                  ),
                  if (state.isHovered || state.isFocused) ...[
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00D1FF).withOpacity(.1),
                      ),
                    ),
                  ],
                  if (selected) ...[
                    CenterLeft(
                      child: Image.asset(AssetPaths.titleSelectedLeft),
                    ),
                    CenterRight(
                      child: Image.asset(AssetPaths.titleSelectedRight),
                    ),
                  ],
                  Center(
                    child: Text(
                      label.toUpperCase(),
                      style: TextStyles.btn,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
