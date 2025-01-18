import 'dart:ui';

import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/utils/datetime_utils.dart';
import 'package:days/features/home/presentation/widgets/day_dot.dart';
import 'package:days/shared/models/vector2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var addYear = 8, leftDays = 0, todayScrollOffset = 0.0;
  final days = <List<DayDot>>[];
  final DateTime date = DateTime(2001, 6, 28);
  final scrollController = ScrollController();
  var _scrolling = false;
  var blockSize = 22.0;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, init);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/mountain.jpeg'),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low
          ),
        ),
        child: Stack(
          children: [

            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
              child: Container(
                color: Colors.black.withAlpha(200),
              ),
            ),

            SafeArea(
              top: false,
              child: Column(
                children: [
              
                  Expanded(
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [

                        SliverAppBar(
                          floating: false,
                          pinned: false,
                          backgroundColor: Colors.transparent,
                          flexibleSpace: FlexibleSpaceBar(
                            title: const Text('Days'),
                          ),
                          actions: [

                            IconButton(
                              icon: const Icon(CupertinoIcons.calendar),
                              onPressed: () {

                              },
                            )

                          ],
                        ),

                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (_, index) {
                              return Container(
                                margin: Dimensions.normalPadding.paddingHorizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    for (final dot in days[index])
                                      SizedBox(
                                        key: ValueKey(dot.position),
                                        height: blockSize,
                                        child: dot,
                                      )
                                  ],
                                ),
                              );
                            },
                            childCount: days.length,
                          ),
                        ),

                      ],
                    ),
                  ),
              
                  Container(
                    margin: Dimensions.normalPadding.padding.copyWith(
                      bottom: Dimensions.empty,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Expanded(
                          child: Text(
                            DateTime.now().year.toString(),
                          ),
                        ),

                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              scrollTo(todayScrollOffset);
                            },
                            child: Text(
                              'Today',
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            'Left $leftDays days',
                            textAlign: TextAlign.right,
                          ),
                        )

                      ],
                    ),
                  ),

                ],
              ),
            ),

          ]
        ),
      ),
    );
  }

  void init() {

    final size = MediaQuery.of(context).size;
    final dayPerRow = size.width ~/ blockSize;
    final year = date.year;
    final now = DateTime.now();

    final yearsInDays = DateTimeUtils.getDaysFrom(
      date,
      DateTime(date.year + 100, 12, 31),
    );

    leftDays = DateTimeUtils.getDaysFrom(date, now);

    for (var i = 0; i < yearsInDays / dayPerRow; i++) {

      final children = <DayDot>[];

      for (var j = 0; j < dayPerRow; j++) {

        final day = DateTime(year, 1, 0).add(Duration(days: i * dayPerRow + j));
        final isBefore = day.isBefore(now);

        if (day.isBefore(now)) {
          todayScrollOffset += 1.255;
        }

        children.add(
          DayDot(
            key: ValueKey(Vector2(j.toDouble(), i.toDouble())),
            Vector2(j.toDouble(), i.toDouble()),
            date: day,
            isBefore: isBefore,
            color: isBefore
                ? Colors.white12
                : Colors.white
          ),
        );
      }

      days.add(children);

    }

    if (mounted) {
      Future.delayed(Duration.zero, () => scrollTo(todayScrollOffset));
      setState(() { });
    }

  }

  void scrollTo(double offset) {
    if (_scrolling) {
      return;
    }

    _scrolling = true;

    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 2000),
      curve: Curves.easeInOutQuart,
    ).then((_) => _scrolling = false);
  }

}
