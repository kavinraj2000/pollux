import 'package:flutter/material.dart';

class Screen1Editor extends StatelessWidget {
  const Screen1Editor({super.key});

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    _buildTagRow(),
                    const SizedBox(height: 12),
                    _buildHeroCard(),
                    const SizedBox(height: 16),
                    _buildToolRow(),
                    const SizedBox(height: 16),
                    _buildMediaRow(),
                    const SizedBox(height: 16),
                    _buildDescriptionCard(),
                    const SizedBox(height: 16),
                    _buildActionBar(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
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

  Widget _buildTagRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _chip('Typography', isActive: true),
          const SizedBox(width: 8),
          _chip('AI AGENT APP'),
          const SizedBox(width: 8),
          _chip('Text'),
        ],
      ),
    );
  }

  Widget _chip(String label, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: isActive ? const Color(0xFF1A1A1A) : const Color(0xFFE0E0E0)),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.white : const Color(0xFF555555))),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D0D0D), Color(0xFF2A2A2A)],
        ),
      ),
      child: Stack(
        children: [
          // Blurred athlete figures (simulated with colored overlays)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFFFF6B35).withOpacity(0.3),
                    const Color(0xFFFF8C42).withOpacity(0.2),
                  ],
                ),
              ),
            ),
          ),
          // Left figure glow
          Positioned(
            bottom: 10,
            left: 30,
            child: Container(
              width: 60,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFF6B35).withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Center figure glow
          Positioned(
            bottom: 10,
            left: 100,
            child: Container(
              width: 70,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF4FC3F7).withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Right figure glow
          Positioned(
            bottom: 10,
            right: 40,
            child: Container(
              width: 55,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFAB47BC).withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Text overlay
          const Positioned(
            top: 24,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Engineered Comfort,',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: 1.2)),
                Text('Maximum Running Speed',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: 1.2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          _toolDropdown('Alex Brush'),
          const SizedBox(width: 8),
          _toolDropdown('tips'),
          const Spacer(),
          _colorBox(),
          const SizedBox(width: 8),
          _formatBtn(Icons.format_bold),
          _formatBtn(Icons.format_underline),
          _formatBtn(Icons.format_italic),
        ],
      ),
    );
  }

  Widget _toolDropdown(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 14),
        ],
      ),
    );
  }

  Widget _colorBox() {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Text('#',
            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _formatBtn(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Icon(icon, size: 18, color: const Color(0xFF555555)),
    );
  }

  Widget _buildMediaRow() {
    return Row(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6B35), Color(0xFF1A1A2E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 32),
        ),
        const SizedBox(width: 10),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF1A1A1A),
          ),
          child: const Icon(Icons.directions_run, color: Colors.white70, size: 28),
        ),
        const SizedBox(width: 10),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: const Color(0xFFE0E0E0), width: 1.5, style: BorderStyle.solid),
            color: Colors.white,
          ),
          child: const Icon(Icons.add, color: Color(0xFF9E9E9E), size: 24),
        ),
      ],
    );
  }

  Widget _buildDescriptionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: const Text(
        'Replace the Vinsel font with a more creative and bold font to make it more elegant, expressive and visually striking, sophisticated.',
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF666666),
            height: 1.6),
      ),
    );
  }

  Widget _buildActionBar() {
    return Row(
      children: [
        _actionBtn(Icons.photo_outlined, 'Image', filled: true),
        const SizedBox(width: 8),
        _actionBtn(Icons.videocam_outlined, 'Video'),
        const SizedBox(width: 8),
        _actionBtn(Icons.mic_outlined, null),
        const Spacer(),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.arrow_upward, color: Colors.white, size: 18),
        ),
      ],
    );
  }

  Widget _actionBtn(IconData icon, String? label, {bool filled = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: label != null ? 12 : 10, vertical: 8),
      decoration: BoxDecoration(
        color: filled ? const Color(0xFFF0F0F0) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF333333)),
          if (label != null) ...[
            const SizedBox(width: 5),
            Text(label,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF333333))),
          ]
        ],
      ),
    );
  }
}