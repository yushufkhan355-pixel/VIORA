import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../theme/app_theme.dart';

class HomeFeed extends StatefulWidget {
  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  final PageController _pageController = PageController();
  // Dummy video URLs for demonstration
  final List<String> _videoUrls = [
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_2mb.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: _videoUrls.length,
        itemBuilder: (context, index) {
          return ReelItem(videoUrl: _videoUrls[index]);
        },
      ),
    );
  }
}

class ReelItem extends StatefulWidget {
  final String videoUrl;
  ReelItem({required this.videoUrl});

  @override
  _ReelItemState createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      _isPlaying ? _controller.play() : _controller.pause();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video Player
        GestureDetector(
          onTap: _togglePlayPause,
          child: Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(color: AppTheme.accent),
          ),
        ),
        
        // Double Tap Like Animation Trigger Area
        GestureDetector(
          onDoubleTap: () {
            // Trigger heart animation logic here
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("❤️ Liked!"), duration: Duration(seconds: 1)),
            );
          },
        ),

        // Right Side Action Bar
        Positioned(
          right: 15,
          bottom: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionButton(icon: Icons.favorite_outline, label: '12.5K', onTap: (){}),
              const SizedBox(height: 25),
              _ActionButton(icon: Icons.comment_outlined, label: '1.2K', onTap: (){}),
              const SizedBox(height: 25),
              _ActionButton(icon: Icons.send_outlined, label: 'Share', onTap: (){}),
              const SizedBox(height: 25),
              _ActionButton(icon: Icons.bookmark_outline, label: 'Save', onTap: (){}),
            ],
          ),
        ),

        // Bottom Creator Info (Glassmorphism)
        Positioned(
          left: 15,
          right: 70,
          bottom: 40,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: AppTheme.glassDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
                    ),
                    const SizedBox(width: 10),
                    const Text('@creator_name', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accent)),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('Follow', style: TextStyle(fontSize: 12, color: Colors.white)),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                const Text('AI Generated Caption ✨ #ViewVerse #Viral', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
