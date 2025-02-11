import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/utils/extensions/grid_type_extension.dart';
import 'package:days/features/home/presentation/widgets/dot/illustrated_dot.dart';
import 'package:days/shared/models/vector2.dart';
import 'package:days/shared/package/grid_builder/grid_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart'
    show
    StatelessWidget,
    Widget,
    BuildContext,
    RawGestureDetector,
    GestureRecognizerFactory,
    GestureRecognizerFactoryWithHandlers;
import 'package:flutter/gestures.dart'
    show
    OneSequenceGestureRecognizer,
    PointerDownEvent,
    GestureDisposition,
    PointerEvent;

class DotGridBody extends StatefulWidget {
  const DotGridBody({super.key});

  @override
  State<DotGridBody> createState() => _DotGridBodyState();
}

class _DotGridBodyState extends State<DotGridBody> {

  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Center(
        child: BlocBuilder<SettingsBloc, SettingsModelState>(
          builder: (context, state) {
            final eventState = state.state;

            if (eventState is SettingsLoaded) {
              final settings = state.entity;

              now = DateTime.now();
              final mediaQuerySize = MediaQuery.sizeOf(context);

              final viewSize = mediaQuerySize.width > Dimensions.maxViewWidthSize
                  ? Dimensions.maxViewWidthSize
                  : mediaQuerySize.width;

              return GridBuilder(
                now: now,
                from: DateTime(now.year),
                to: DateTime(now.year).add(const Duration(days: 365)),
                lengthCalculate: settings.gridType.calculation,
                dayCalculate: settings.gridType.calculationDay,
                padding: Dimensions.doubledNormal.padding,
                blockSize: const Size.square(Dimensions.dotContainerSize),
                viewSize: Size(viewSize, mediaQuerySize.height),
                itemBuilder: (int index, DateTime date, Vector2 position) {
                  return _itemBuilder(
                    index,
                    date,
                    position,
                    settings.gridType,
                  );
                },
              );
            }

            if (eventState is SettingsError) {
              return Text(
                eventState.message.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              );
            }

            return const Center(
              child: CupertinoActivityIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _itemBuilder(int index, DateTime date, Vector2 position, GridType type) {

    if (type.sameWith(now, date)) {
      return IllustratedDot.current(
        key: UniqueKey(),
        position,
        date: date,
      );
    }

    if (date.isBefore(now)) {
      return RepaintBoundary(
        child: IllustratedDot(
          key: UniqueKey(),
          position,
          date: date,
          isActive: true,
        ),
      );
    }

    return RepaintBoundary(
      child: IllustratedDot.after(
        key: UniqueKey(),
        position,
        date: date,
        isActive: false,
      ),
    );
  }
}


class SinglePointerRecognizer extends OneSequenceGestureRecognizer {
  int _p = 0;

  @override
  void addPointer(PointerDownEvent event) {
    startTrackingPointer(event.pointer);

    print('object');
    if (_p == 0) {
      resolve(GestureDisposition.rejected);
      _p = event.pointer;
    } else {
      resolve(GestureDisposition.accepted);
    }
  }

  @override
  String get debugDescription => 'only one pointer recognizer';

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void handleEvent(PointerEvent event) {
    if (!event.down && event.pointer == _p) {
      _p = 0;
    }
  }
}

class SinglePointerRecognizerWidget extends StatelessWidget {
  /// Ignores multi touch gestures on a widget
  const SinglePointerRecognizerWidget({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        SinglePointerRecognizer:
        GestureRecognizerFactoryWithHandlers<SinglePointerRecognizer>(
              () => SinglePointerRecognizer(),
              (SinglePointerRecognizer instance) {
                print('SinglePointerRecognizer');
              },
        )
      },
      child: child,
    );
  }
}