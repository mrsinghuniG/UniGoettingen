import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'dart:math' as math;
import '../screens/webview_page.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);
  int maxCount = 5;

  final List<Widget> bottomBarPages = [
    const HomeContent(),
    const Center(
      child: Text(
        'Page 2',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Center(
      child: Text(
        'Page 3',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Center(
      child: Text(
        'Page 4',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Center(
      child: Text(
        'Page 5',
        style: TextStyle(color: Colors.white),
      ),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0f0f1f), Color(0xFF1a1a2f)],
          ),
        ),
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            bottomBarPages.length,
                (index) => bottomBarPages[index],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        /// Required parameters
        kIconSize: 24,
        kBottomRadius: 28.0,  // Added this required parameter

        notchBottomBarController: _controller,
        color: const Color(0xFF1a1a2f),
        showLabel: true,
        notchColor: const Color(0xFF00ff88),
        removeMargins: false,
        bottomBarWidth: 500,
        durationInMilliSeconds: 300,
        bottomBarItems: [
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Color(0xFF00ff88),
            ),
            itemLabel: 'Home',
          ),
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.star_outline,
              color: Colors.white,
            ),
            activeItem: Icon(
              Icons.star_rounded,
              color: Color(0xFF00ff88),
            ),
            itemLabel: 'Favorites',
          ),
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.search,
              color: Colors.white,
            ),
            activeItem: Icon(
              Icons.search,
              color: Color(0xFF00ff88),
            ),
            itemLabel: 'Search',
          ),
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.settings_outlined,
              color: Colors.white,
            ),
            activeItem: Icon(
              Icons.settings,
              color: Color(0xFF00ff88),
            ),
            itemLabel: 'Settings',
          ),
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
            activeItem: Icon(
              Icons.person,
              color: Color(0xFF00ff88),
            ),
            itemLabel: 'Profile',
          ),
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

// Separate widget for the home content
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // First Row (2 widgets moving left)
          Row(
            children: const [
              Expanded(
                child: GlassWidget(
                  title: 'eCampus',
                  icon: Icons.school,
                  content: 'Access your courses and university resources',
                  url: 'https://www.uni-goettingen.de/',
                  direction: -1,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: GlassWidget(
                  title: 'Flexnow',
                  icon: Icons.assignment,
                  content: 'Manage your exams and study progress',
                  direction: -1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Second Row (2 widgets moving right)
          Row(
            children: const [
              Expanded(
                child: GlassWidget(
                  title: 'Stellenwerk',
                  icon: Icons.work,
                  content: 'Find student jobs and career opportunities',
                  direction: 1,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: GlassWidget(
                  title: 'Asta',
                  icon: Icons.group,
                  content: 'Student union services and activities',
                  direction: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Third Row (2 widgets moving left)
          Row(
            children: const [
              Expanded(
                child: GlassWidget(
                  title: 'City',
                  icon: Icons.location_city,
                  content: 'Explore city services and student discounts',
                  direction: -1,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: GlassWidget(
                  title: 'Help',
                  icon: Icons.help,
                  content: 'Get support and assistance',
                  direction: -1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// GlassWidget class
class GlassWidget extends StatefulWidget {
  final String title;
  final IconData icon;
  final String content;
  final String? url;
  final int direction;

  const GlassWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.content,
    this.url,
    required this.direction,
  });

  @override
  State<GlassWidget> createState() => _GlassWidgetState();
}

class _GlassWidgetState extends State<GlassWidget> with TickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final AnimationController _floatController;
  late final AnimationController _particleController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _floatController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() {
        _isHovered = true;
        _hoverController.forward();
      }),
      onExit: (event) => setState(() {
        _isHovered = false;
        _hoverController.reverse();
      }),
      child: AnimatedBuilder(
        animation: Listenable.merge([_hoverController, _floatController]),
        builder: (context, child) {
          final floatValueY = math.sin(_floatController.value * 2 * math.pi) * 10;
          final floatValueX = widget.direction * math.cos(_floatController.value * 2 * math.pi) * 10;

          return Transform.translate(
            offset: Offset(floatValueX, floatValueY - (10 * _hoverController.value)),
            child: GestureDetector(
              onTap: () {
                if (widget.url != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewPage(url: widget.url!),
                    ),
                  );
                } else {
                  print('${widget.title} clicked');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.05),
                      Colors.white.withOpacity(0.15),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: -100 + (200 * _hoverController.value),
                      child: Container(
                        width: 100,
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    ...List.generate(8, (index) => _buildParticle(index)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            widget.icon,
                            size: 40,
                            color: const Color(0xFF00ff88),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.content,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildParticle(int index) {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        final value = _particleController.value * 2 * (1 + (index % 2));
        return Positioned(
          left: (MediaQuery.of(context).size.width * 0.25) *
              (0.5 + 0.5 * math.sin(value + index)),
          top: (MediaQuery.of(context).size.width * 0.25) *
              (0.5 + 0.5 * math.cos(value + index)),
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: const Color(0xFF00ff88).withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}//main - navigation bar