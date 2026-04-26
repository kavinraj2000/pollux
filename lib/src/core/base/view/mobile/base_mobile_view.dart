import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pollux/app/route_name.dart';
import 'package:pollux/src/feature/auth/login/view/mobile/login_mobile_view.dart';
import '../../bloc/base_bloc.dart';

class BaseMobileView extends StatefulWidget {
  const BaseMobileView({super.key});

  @override
  State<BaseMobileView> createState() => _BaseMobileViewState();
}

class _BaseMobileViewState extends State<BaseMobileView>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _hasNavigated = false;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;

    context.read<BaseBloc>().add(ScrollOffsetChanged(offset));

    if (offset >= _scrollController.position.maxScrollExtent &&
        !_hasNavigated &&
        _scrollController.position.maxScrollExtent > 0) {
      _hasNavigated = true;
      context.goNamed(RouteName.login);
    }
  }

  // void _navigateToLogin() {
  //   Navigator.of(context)
  //       .push(
  //         PageRouteBuilder(
  //           pageBuilder: (_, __, ___) => context.goNamed(RouteName.login),
  //           transitionsBuilder: (_, animation, __, child) {
  //             final tween = Tween<Offset>(
  //               begin: const Offset(0, 1),
  //               end: Offset.zero,
  //             ).chain(CurveTween(curve: Curves.easeOutCubic));
  //             return SlideTransition(
  //               position: animation.drive(tween),
  //               child: child,
  //             );
  //           },
  //           transitionDuration: const Duration(milliseconds: 500),
  //         ),
  //       )
  //       .then((_) => _hasNavigated = false);
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        final screenHeight = MediaQuery.of(context).size.height;
        final scrollOffset = state.scrollOffset;
        final parallaxOffset = scrollOffset * 0.5;

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // ── LAYER 1: Scrolling background (parallax) ──
              Positioned(
                top: -parallaxOffset,
                left: 0,
                right: 0,
                height: screenHeight * 2.5,
                child: Image.asset(
                  'assets/image/download.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF0D0D1A), Color(0xFF1A1A3E)],
                      ),
                    ),
                  ),
                ),
              ),

              // ── LAYER 2: Dark gradient overlay (static) ──
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),

              // ── LAYER 3: Scrollable area (drives scroll events only) ──
              Positioned.fill(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(height: screenHeight * 2),
                ),
              ),

              // ── LAYER 4: Static camera image ──
              Positioned(
                top: screenHeight * 0.18,
                left: 24,
                right: 24,
                child: Image.asset(
                  'assets/image/camara.png',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white.withOpacity(0.6),
                    size: 120,
                  ),
                ),
              ),

              // ── LAYER 5: Scroll-offset badge ──
              Positioned(
                top: 56,
                left: 24,
                child: AnimatedOpacity(
                  opacity: scrollOffset > 20 ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Text(
                      '↑ ${scrollOffset.toInt()}px',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              // ── LAYER 6: Bottom UI ──
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    const Text(
                      'CAMERA PRO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '4K Ultra HD · f/2.8 · 1/8000s',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.55),
                        fontSize: 13,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ScaleTransition(
                      scale: _pulseAnimation,
                      child: Column(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white.withOpacity(0.8),
                            size: 28,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            scrollOffset > screenHeight * 0.5
                                ? 'Keep scrolling to login'
                                : 'Scroll down to explore',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.45),
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
