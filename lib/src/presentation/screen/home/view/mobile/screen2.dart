import 'package:flutter/material.dart';

class Screen2Images extends StatelessWidget {
  const Screen2Images({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F4),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    _buildImageGrid(),
                    const SizedBox(height: 16),
                    _buildAddImageButton(),
                    const SizedBox(height: 16),
                    _buildBottomGrid(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFF1A1A1A),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 8),
              const Text('ORRISO',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: Color(0xFF1A1A1A))),
            ],
          ),
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE5E5E5)),
                ),
                child: const Icon(Icons.more_horiz, size: 18, color: Color(0xFF1A1A1A)),
              ),
              const SizedBox(width: 8),
              Container(
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.save_outlined, size: 14, color: Colors.white),
                    SizedBox(width: 5),
                    Text('Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column
        Expanded(
          child: Column(
            children: [
              _imageCard(
                height: 180,
                child: _soccerImage(),
              ),
              const SizedBox(height: 8),
              _imageCard(
                height: 160,
                child: _colorBlurImage(const Color(0xFF4FC3F7)),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Right column
        Expanded(
          child: Column(
            children: [
              _imageCard(
                height: 140,
                child: _bwSoccerImage(),
              ),
              const SizedBox(height: 8),
              _imageCard(
                height: 200,
                child: _colorBlurImage(const Color(0xFFAB47BC)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _imageCard({required double height, required Widget child}) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFFE0E0E0),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  Widget _soccerImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF4CAF50)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        const Center(
          child: Icon(Icons.sports_soccer, size: 52, color: Colors.white70),
        ),
        Positioned(
          bottom: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text('Match Photo',
                style: TextStyle(color: Colors.white, fontSize: 10)),
          ),
        ),
      ],
    );
  }

  Widget _bwSoccerImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: const Color(0xFF424242)),
        const Center(
          child: Icon(Icons.directions_run, size: 48, color: Colors.white54),
        ),
        // B&W overlay effect
        Container(
          color: Colors.grey.withOpacity(0.4),
        ),
      ],
    );
  }

  Widget _colorBlurImage(Color color) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                color.withOpacity(0.8),
                color.withOpacity(0.3),
                Colors.black87,
              ],
            ),
          ),
        ),
        Center(
          child: Icon(
            Icons.person,
            size: 56,
            color: color.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildAddImageButton() {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          style: BorderStyle.solid,
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_outline, size: 18, color: Color(0xFF9E9E9E)),
          SizedBox(width: 8),
          Text('Add image',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF9E9E9E))),
        ],
      ),
    );
  }

  Widget _buildBottomGrid() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _imageCard(
            height: 130,
            child: _greenGrassImage(),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: const Center(
                  child: Icon(Icons.add, color: Color(0xFFBDBDBD), size: 22),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E8E8),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _greenGrassImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
            ),
          ),
        ),
        const Center(
          child: Icon(Icons.sports, size: 40, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    final actions = [
      (Icons.add_box_outlined, 'Add'),
      (Icons.grid_view, 'Grid'),
      (Icons.share_outlined, 'Share'),
      (Icons.notifications_none, 'Alerts'),
      (Icons.person_outline, 'Profile'),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions.map((a) {
          return Icon(a.$1, color: Colors.white.withOpacity(0.85), size: 22);
        }).toList(),
      ),
    );
  }
}