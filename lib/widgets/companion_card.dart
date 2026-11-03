import 'package:flutter/material.dart';
import '../models/companion_theme.dart';

class CompanionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final CompanionTheme theme;
  final bool hasGlow;
  final Color? backgroundColor;
  final Color? borderColor;

  const CompanionCard({
    super.key,
    required this.child,
    required this.theme,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.onTap,
    this.hasGlow = false,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor ?? theme.cardBorder,
          width: 1.0,
        ),
        boxShadow: hasGlow ? theme.glow : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: theme.primary.withValues(alpha: 0.12),
          highlightColor: theme.primary.withValues(alpha: 0.06),
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}

