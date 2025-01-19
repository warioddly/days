import 'dart:ui';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/presentation/widgets/app_bar.dart';
import 'package:days/shared/ui/dot/dot.dart';
import 'package:days/shared/ui/dot/dots_list_builder.dart';
import 'package:days/shared/utils/dot_builder_utils.dart';
import 'package:days/shared/utils/enums/view_type_enum.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var left = 0, todayScrollOffset = 0.0, _scrolling = false;

  final viewType = ValueNotifier(ViewType.months);
  final date = DateTime(2001, 6, 28);
  final scrollController = ScrollController();

  List<List<Dot>> dots = <List<Dot>>[];

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

                        HomeAppBar(
                          viewType: viewType.value,
                          onTypeChanged: (ViewType type) {
                            viewType.value = type;
                            init();
                          },
                        ),

                        ValueListenableBuilder(
                          valueListenable: viewType,
                          builder: (context, value, child) {
                            return DotsListBuilder(
                                dots: dots
                            );
                          },
                        ),

                      ],
                    ),
                  ),
              
                  Container(
                    margin: Dimensions.dotContainerSize.padding.copyWith(
                      top: Dimensions.small,
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
                              'Tøday',
                            ),
                          ),
                        ),

                        Expanded(
                          child: GestureDetector(
                            onTap: () => scrollTo(0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: left.toString(),
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  TextSpan(
                                    text: ' left ${viewType.value.name.toLowerCase()}',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.right,
                            ),
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

    dots = DotBuilderUtils.buildDots(
        from: date,
        to: to,
        now: now,
        viewType: viewType.value,
        dotsPerRow: dotsPerRow,
        beforeOffsetCallback: (int index) {
          todayScrollOffset = (index * dotContainerSize) + (dotsPerColumn - safeAreaCompensation);
        },
    );

    left = viewType.value.calculation(date, now);

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
