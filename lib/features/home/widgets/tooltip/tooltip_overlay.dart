import 'dart:async';
import 'package:days/core/utils/datetime_utils.dart';
import 'package:days/features/home/widgets/tooltip/tooltip_overlay_entry.dart';
import 'package:flutter/material.dart';

final class TooltipOverlay {
  TooltipOverlay(BuildContext context) : _context = context;

  Timer? _timer;
  OverlayEntry? _overlayEntry;
  bool _isVisible = false;
  Offset _position = Offset.zero;
  DateTime _content = DateTime.now();
  final BuildContext _context;

  void update(Offset position, DateTime date) {
    show();
    _position = position;
    _content = date;
    _marksNeedsBuild();
  }

  void show() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 3), hide);

    if (_isVisible) return;
    _isVisible = true;

    _createOverlay();
  }

  void hide() {
    if (!_isVisible) return;
    _isVisible = false;
    _overlayEntry?.remove();
  }

  void _createOverlay() {
    _overlayEntry = _tooltipOverlayEntry();
    if (_overlayEntry == null) return;
    Overlay.of(_context).insert(_overlayEntry!);
  }

  OverlayEntry _tooltipOverlayEntry() {
    return OverlayEntry(
      builder: (_) => TooltipOverlayEntry(
        content: DateTimeUtils.format(_content),
        position: _position,
      ),
    );
  }

  void _marksNeedsBuild() {
    _overlayEntry?.markNeedsBuild();
  }

  void dispose() {
    try {
      _timer?.cancel();
      _timer = null;
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isVisible = false;
    } catch (_) {}
  }
}
