import 'dart:ui';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/utils/datetime_utils.dart';
import 'package:days/shared/ui/dot/dot.dart';
import 'package:days/shared/ui/dot/dots_list_builder.dart';
import 'package:days/shared/utils/dot_builder_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var leftDays = 0, todayScrollOffset = 0.0, _scrolling = false;

  final date = DateTime(2001, 6, 28);
  final scrollController = ScrollController();

  List<List<Dot>> days = <List<Dot>>[];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, init);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
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
                            centerTitle: true,
                          ),
                          actions: [

                            IconButton(
                              icon: const Icon(CupertinoIcons.calendar),
                              onPressed: () {

                              },
                            )

                          ],
                        ),

                        DotsListBuilder(days: days),

                      ],
                    ),
                  ),
              
                  Container(
                    margin: Dimensions.dotContainerSize.padding.copyWith(
                      top: Dimensions.smallPadding,
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
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: leftDays.toString(),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: ' left days',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
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

    final now = DateTime.now();
    final to = DateTime(date.year + 100, 12, 31);

    final dotContainerSize = Dimensions.dotContainerSize;

    final size = MediaQuery.of(context).size;
    final dotsPerRow = ((size.width - (dotContainerSize / 2 + Dimensions.dotSize) * 2) ~/ dotContainerSize);
    final dotsPerColumn = size.height ~/ dotContainerSize;
    final safeAreaInsets = MediaQuery.of(context).padding;
    final safeAreaCompensation = safeAreaInsets.bottom;

    days = DotBuilderUtils.buildDots(
        from: date,
        to: to,
        now: now,
        dotsPerRow: dotsPerRow,
        beforeOffsetCallback: (int index) {
          todayScrollOffset = (index * dotContainerSize) + (dotsPerColumn - safeAreaCompensation);
        },
    );

    leftDays = DateTimeUtils.getDaysFrom(date, now);

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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

}
