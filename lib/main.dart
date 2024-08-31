import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:hotstar/widgets/custom_button.dart';
import 'package:hotstar/widgets/custom_fab.dart';
import 'package:hotstar/widgets/shimmer_button.dart';
import 'widgets/number_card.dart';

void main() {
  runApp(const DisneyHotstarApp());
}

class DisneyHotstarApp extends StatelessWidget {
  const DisneyHotstarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disney Hotstar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _currentCarouselIndex = 0;
  bool showMoreOnly = false;

  final ScrollController _scrollController = ScrollController();
  bool _isAppBarTransparent = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final scrollPosition = _scrollController.position.pixels;
    final scrollDirection = _scrollController.position.userScrollDirection;

    if (scrollPosition <= 0) {
      if (!_isAppBarTransparent) {
        setState(() {
          log('not transparent');
          _isAppBarTransparent = true;
        });
      }
    } else if (scrollDirection == ScrollDirection.forward) {
      if (_isAppBarTransparent) {
        log('forward');
        setState(() {
          _isAppBarTransparent = false;
        });
      }
    } else {
      if (!_isAppBarTransparent) {
        setState(() {
          _isAppBarTransparent = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          scrollBehavior: const CupertinoScrollBehavior(),
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          slivers: [
            _buildSliverAppBar(),
            _buildCarouselHeader(),
            _buildHorizontalListSection('Trending Now',
                'https://image.tmdb.org/t/p/w600_and_h900_bestv2/gdIrmf2DdY5mgN6ycVP0XlzKzbE.jpg'),
            _buildTop10ItemsList(),
            _buildHorizontalListSection('Popular Shows',
                'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/dDBTUSl3tRsOeKC1jZugBSFHy9I.jpg',
                firstText: 'Free ', isNew: true),
            _buildHorizontalListSection('New Releases',
                'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/ygmJUf1cCmdye5eyKqLxHsxAJDS.jpg'),
            _buildHorizontalListSection('Popular Shows',
                'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/dDBTUSl3tRsOeKC1jZugBSFHy9I.jpg',
                firstText: 'Free ', isNew: true),
            _buildHorizontalListSection('New Releases',
                'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/ygmJUf1cCmdye5eyKqLxHsxAJDS.jpg'),
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: const CustomFAB(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  SliverOverlapAbsorber _buildSliverAppBar() {
    return SliverOverlapAbsorber(
      handle: SliverOverlapAbsorberHandle(),
      sliver: SliverAppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        expandedHeight: 57,
        floating: true,
        pinned: true,
        backgroundColor:
            _isAppBarTransparent ? Colors.transparent : Colors.grey[900],
        flexibleSpace: FlexibleSpaceBar(
          background: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/hotstarpng.png',
                  color: Colors.white,
                  scale: 6,
                ),
                Row(
                  children: [
                    ShimmerButton(onPressed: () {}, text: 'Subscribe'),
                    IconButton(
                      icon: const Icon(Icons.cast_rounded),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // REFACTORED WIDGETS

  Widget _buildCarouselHeader() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          _buildCarousel(),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  children: [
                    const Spacer(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Languages', style: TextStyle(fontSize: 11)),
                        SizedBox(width: 4),
                        Icon(
                          Icons.circle,
                          size: 4,
                        ),
                        SizedBox(width: 4),
                        Text('Genre', style: TextStyle(fontSize: 11)),
                        SizedBox(width: 4),
                        Icon(
                          Icons.circle,
                          size: 4,
                        ),
                        SizedBox(width: 4),
                        Text('Genre2', style: TextStyle(fontSize: 11)),
                        SizedBox(width: 4),
                        Icon(
                          Icons.circle,
                          size: 4,
                        ),
                        SizedBox(width: 4),
                        Text('Genre3', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 45,
                          child: CustomButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 14),
                            onPressed: () {},
                            child: const Row(
                              children: [
                                Icon(
                                  CupertinoIcons.play_fill,
                                  size: 15,
                                ),
                                SizedBox(width: 10),
                                Text('Watch Now'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 45,
                          child: CustomButton(
                            padding: const EdgeInsets.all(10),
                            onPressed: () {},
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTop10ItemsList() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top 10 - Country',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 170.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) => NumberCard(
                  index: index,
                  imageUrl:
                      'https://image.tmdb.org/t/p/w600_and_h900_bestv2/xYduFGuch9OwbCOEUiamml18ZoB.jpg',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 500.0,
        viewportFraction: 1.0,
        autoPlay: true,
        onPageChanged: (index, reason) {
          setState(() {
            _currentCarouselIndex = index;
          });
        },
      ),
      items: [
        'https://image.tmdb.org/t/p/w600_and_h900_bestv2/gdIrmf2DdY5mgN6ycVP0XlzKzbE.jpg',
        'https://image.tmdb.org/t/p/w600_and_h900_bestv2/xYduFGuch9OwbCOEUiamml18ZoB.jpg',
        'https://image.tmdb.org/t/p/w600_and_h900_bestv2/iiZZdoQBEYBv6id8su7ImL0oCbD.jpg',
      ].map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 350,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black,
                            Colors.transparent,
                          ],
                          stops: [0, .8],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }

  List<Widget> _buildPageIndicator() {
    return List<Widget>.generate(3, (index) {
      return Container(
        width: 8.0,
        height: 8.0,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              _currentCarouselIndex == index ? Colors.white : Colors.grey[800],
        ),
      );
    });
  }

  Widget _buildHorizontalListSection(String title, String url,
      {String? firstText, bool isNew = false}) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: RichText(
              text: TextSpan(
                children: [
                  if (firstText != null)
                    TextSpan(
                      text: firstText,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  TextSpan(
                    text: title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return _buildMovieCard(url, isNew: isNew);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieCard(String url, {bool isNew = false}) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
      child: isNew
          ? Stack(
              children: [
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeBlue,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Text(
                      'FREE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          activeIcon: Icon(CupertinoIcons.house_fill),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          activeIcon: Icon(CupertinoIcons.search_circle_fill),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.bolt),
          activeIcon: Icon(CupertinoIcons.bolt_fill),
          label: 'New & Hot',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.arrow_down_to_line),
          activeIcon: Icon(CupertinoIcons.arrow_down_to_line_alt),
          label: 'Downloads',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.profile_circled),
          label: 'Menu',
        ),
      ],
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
    );
  }
}
