import 'package:flutter/material.dart';

class Screen3Files extends StatelessWidget {
  const Screen3Files({super.key});

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
                    _buildSectionLabel('AI Agent'),
                    const SizedBox(height: 10),
                    _buildAgentGrid(),
                    const SizedBox(height: 20),
                    _buildSectionLabel('Files Viewer'),
                    const SizedBox(height: 10),
                    _buildFilesGrid(),
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
        children: [
          // Back button
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5E5E5)),
            ),
            child: const Icon(Icons.arrow_back_ios_new,
                size: 14, color: Color(0xFF1A1A1A)),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Back',
                  style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
              Text('Generation',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A))),
            ],
          ),
          const Spacer(),
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5E5E5)),
            ),
            child: const Row(
              children: [
                Icon(Icons.download_outlined,
                    size: 14, color: Color(0xFF1A1A1A)),
                SizedBox(width: 5),
                Text('Load',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A))),
                SizedBox(width: 3),
                Icon(Icons.keyboard_arrow_down,
                    size: 14, color: Color(0xFF1A1A1A)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(label,
        style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF9E9E9E),
            letterSpacing: 0.3));
  }

  Widget _buildAgentGrid() {
    final agents = [
      ('Storyboarder', const Color(0xFF5B8DB8), true),
      ('Optimizer', const Color(0xFFE8A87C), true),
      ('Visualizer', const Color(0xFFB0B0B0), false),
      ('Copywriter', const Color(0xFFB0B0B0), false),
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: agents.map((a) => _agentCard(a.$1, a.$2, a.$3)).toList(),
    );
  }

  Widget _agentCard(String name, Color color, bool isActive) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? color : const Color(0xFFE8E8E8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(name,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isActive ? Colors.white : const Color(0xFFBBBBBB))),
          ],
        ),
      ),
    );
  }

  Widget _buildFilesGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _fileCard(
          title: 'Documents',
          subtitle: '3 files',
          icon: Icons.description_outlined,
          color: const Color(0xFFEEEEEE),
          iconColor: const Color(0xFF616161),
        ),
        _fileCardImage(
          title: 'Street poster',
          subtitle: '5 files',
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6B35), Color(0xFF1A1A2E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        _fileCardImage(
          title: 'Recent',
          subtitle: '6 files',
          gradient: const LinearGradient(
            colors: [Color(0xFFAB47BC), Color(0xFF4CAF50)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        _fileCardPaper(
          title: 'Flyers',
          subtitle: '5 files',
        ),
      ],
    );
  }

  Widget _fileCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const Spacer(),
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A))),
          const SizedBox(height: 2),
          Text(subtitle,
              style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
        ],
      ),
    );
  }

  Widget _fileCardImage({
    required String title,
    required String subtitle,
    required Gradient gradient,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: gradient,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.image_outlined, color: Colors.white, size: 22),
          ),
          const Spacer(),
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          const SizedBox(height: 2),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12, color: Colors.white.withOpacity(0.7))),
        ],
      ),
    );
  }

  Widget _fileCardPaper({
    required String title,
    required String subtitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9F0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEE8DF)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Paper stack illustration
          Stack(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFFCC80)),
                ),
              ),
              Positioned(
                top: 3,
                left: 3,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: const Icon(Icons.article_outlined,
                      color: Color(0xFF8D6E63), size: 20),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A))),
          const SizedBox(height: 2),
          Text(subtitle,
              style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
        ],
      ),
    );
  }
}