import 'package:hotstar/colors.dart';
import 'package:hotstar/widgets/card_item.dart';

import 'package:flutter/material.dart';

class CustomFAB extends StatefulWidget {
  const CustomFAB({super.key});

  @override
  CustomFABState createState() => CustomFABState();
}

class CustomFABState extends State<CustomFAB>
    with SingleTickerProviderStateMixin {
  int _selectedTabIndex = -1;
  bool _isShrunk = false;
  bool _isFaded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isShrunk ? .1 : 1,
      duration: const Duration(milliseconds: 1200),
      child: AnimatedSlide(
        offset: Offset(0, _isFaded ? 1 : 0.2),
        duration: Durations.extralong4,
        child: AnimatedOpacity(
          curve: Curves.ease,
          opacity: _isFaded ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
            child: _isShrunk
                ? const SizedBox.shrink()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int index = 0;
                                  index < actions.length;
                                  index++)
                                AnimatedSize(
                                  // switchInCurve: Curves.ease,
                                  duration: const Duration(milliseconds: 300),
                                  child: _selectedTabIndex == -1 ||
                                          _selectedTabIndex == index
                                      ? TextButton(
                                          key: ValueKey<int>(index),
                                          onPressed: () {
                                            changeVisibility(index);
                                            if (_selectedTabIndex == 3) {
                                              Future.delayed(
                                                Durations.extralong3,
                                                () => showModalBottomSheet(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        12),
                                                                topRight: Radius
                                                                    .circular(
                                                                        12))),
                                                        context: context,
                                                        builder:
                                                            _showModalSheetItems)
                                                    .whenComplete(
                                                        () => setState(() {
                                                              _selectedTabIndex =
                                                                  -1;
                                                            })),
                                              );
                                            }
                                          },
                                          child: index == actions.length - 1
                                              ? Row(
                                                  children: [
                                                    Text(actions[index],
                                                        style: style),
                                                    const Icon(
                                                      Icons
                                                          .keyboard_arrow_up_rounded,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                )
                                              : Text(actions[index],
                                                  style: style),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void changeVisibility(int index) {
    setState(() {
      if (_selectedTabIndex == index) {
        _selectedTabIndex = -1;
      } else {
        _selectedTabIndex = index;
        Future.delayed(
            const Duration(milliseconds: 600), () => _isShrunk = true);
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        if (_selectedTabIndex != -1) {
          _isFaded = true;
        }
      });
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      setState(() {
        _isShrunk = false;
        _isFaded = false;
      });
    });
  }

  final List<String> actions = [
    'TV',
    'Movies',
    'Sports',
    'More',
  ];

  Widget _showModalSheetItems(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _gridViewModalSheetItems(),
              logoListViewHorizontal(
                'Logo',
                'https://s3.amazonaws.com/cdn.designcrowd.com/blog/40-Famous-Film-Company-Logos/Pixar.png',
                Colors.black87,
              ),
              logoListViewHorizontal(
                'Logo',
                'https://s3.amazonaws.com/cdn.designcrowd.com/blog/40-Famous-Film-Company-Logos/Disney.png',
                Colors.black87,
              ),
              logoListViewHorizontal(
                'Logo',
                'https://s3.amazonaws.com/cdn.designcrowd.com/blog/40-Famous-Film-Company-Logos/Metro-Goldwyn-Mayer.png',
                Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }

  GridView _gridViewModalSheetItems() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.2 / .8,
      ),
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (context, index) {
        return const CardItem(
          imageUrl:
              'https://s3.amazonaws.com/cdn.designcrowd.com/blog/40-Famous-Film-Company-Logos/Metro-Goldwyn-Mayer.png',
          color: Colors.black,
        );
      },
    );
  }
}

Widget logoListViewHorizontal(String title, String imageUrl, Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Popular',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return CardItem(
              title: title,
              imageUrl: imageUrl,
              color: color,
            );
          },
        ),
      ),
    ],
  );
}
