import 'dart:async';

import 'package:days/core/constants/app_constants.dart';
import 'package:days/core/utils/datetime_utils.dart';
import 'package:days/features/home/presentation/widgets/tooltip/tooltip_overlay_entry.dart';
import 'package:flutter/material.dart';

const _tooltipDeactivateDuration = Duration(
  milliseconds: AppConstants.deactivateDotDurationInMilliseconds,
);

final class TooltipOverlay {
  Timer? _timer;
  OverlayEntry? _overlayEntry;
  bool _isVisible = false;
  Offset _position = Offset.zero;
  DateTime _content = DateTime.now();

  void update(BuildContext context, Offset position, DateTime date) {
    show(context);
    _position = position;
    _content = date;
    _marksNeedsBuild();
  }

  void show(BuildContext context) {
    _timer?.cancel();
    _timer = Timer(_tooltipDeactivateDuration, hide);

    if (_isVisible) return;
    _isVisible = true;

    _createOverlay(context);
  }

  void hide() {
    if (!_isVisible) return;
    _isVisible = false;
    _overlayEntry?.remove();
  }

  void _createOverlay(BuildContext context) {
    _overlayEntry = _tooltipOverlayEntry(context);
    if (_overlayEntry == null) return;
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _tooltipOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (_) {
        final content = DateTimeUtils.format(_content);
        return TooltipOverlayEntry(content: content, position: _position);
      },
    );
  }

  void _marksNeedsBuild() {
    _overlayEntry?.markNeedsBuild();
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }
}
