import 'package:esoteric_volume/levels.dart';
import 'package:flutter/material.dart';

class LevelSelector extends StatelessWidget {
  final void Function(Level) onTap;

  const LevelSelector({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: Level.levelsCount,
      separatorBuilder: (c, i) => const Divider(height: 0),
      itemBuilder: (final ctx, final idx) {
        final level = Level.levels[idx];
        return ListTile(
          title: Text('Level ${level.number}'),
          onTap: () => onTap(level),
        );
      },
    );
  }
}
