import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyric App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBE0026)),
        fontFamily: 'Inter',
      ),
      home: const AppleMusicLyricsPage(),
    );
  }
}

// ── Lyric data model ──────────────────────────────────────────────────────────
class LyricLine {
  final String text;
  final int startSec; // time in seconds when this line becomes active
  const LyricLine(this.text, this.startSec);
}

// ── Song data ─────────────────────────────────────────────────────────────────
const List<LyricLine> _lyrics = [
  LyricLine("To the tempo of your uptight", 0),
  LyricLine("Is the flicker of a street light", 5),
  LyricLine("You know this moment, don't ya?", 10),
  LyricLine("And time is strangely calm now", 15),
  LyricLine("'Cause everybody's gone, it's", 20),
  LyricLine("Just you and your anger", 25),
  LyricLine("Oh, golden boy, don't act like you were kind", 32),
  LyricLine("You were mine but you were awful every time", 38),
  LyricLine("So don't tell them what you told me", 44),
  LyricLine("Don't hold me like you know me", 49),
  LyricLine("I would rather burn forever", 54),
  LyricLine("But you should know that I died slow", 61),
  LyricLine("Running through the halls of your haunted home", 67),
  LyricLine("And the toughest part is that we both know", 73),
  LyricLine("What happened to you", 79),
  LyricLine("Why you're out on your own", 83),
  LyricLine("Merry Christmas, please don't call", 88),
  LyricLine("You really left me on the line, kid", 96),
  LyricLine("Holding all your baggage", 101),
  LyricLine("You know I'm not your father", 106),
  LyricLine("Who says welcome to your uptight", 111),
  LyricLine("While it flickers like a street light", 116),
  LyricLine("He flickers through your damage", 121),
  LyricLine("Oh, golden boy, you shined a light on your home", 128),
  LyricLine("And at your best you were magic, we were sold", 134),
  LyricLine("But don't tell 'em what you told me", 140),
  LyricLine("Don't even tell 'em that you know me", 145),
  LyricLine("I would rather burn forever", 150),
  LyricLine("But you should know that I died slow", 157),
  LyricLine("Running through the halls of your haunted home", 163),
  LyricLine("And the toughest part is that we both know", 169),
  LyricLine("What happened to you", 175),
  LyricLine("Why you're out on your own", 179),
  LyricLine("Merry Christmas, please don't call", 184),
  LyricLine("Just one ticket out of your heavy gaze", 192),
  LyricLine("I want one ticket off of your carousel", 198),
  LyricLine("I want one ticket out of your heavy gaze", 204),
  LyricLine("I want one ticket off of your carousel", 210),
  LyricLine("Only, you should know that I died slow", 217),
  LyricLine("Running through the halls of your haunted home", 223),
  LyricLine("And the toughest part is that we both know", 229),
  LyricLine("What happened to you", 235),
  LyricLine("Why you're out on your own", 239),
  LyricLine("Merry Christmas, please don't call", 244),
  LyricLine("Merry Christmas, I'm not yours at all", 250),
  LyricLine("Merry Christmas, please don't call me", 256),
  LyricLine("Please don't call me", 261),
  LyricLine("Please don't call me", 265),
  LyricLine("Please don't call me", 269),
];

const int _totalDurationSec = 275; // ~4:35

// ── Main Lyrics Page ──────────────────────────────────────────────────────────
class AppleMusicLyricsPage extends StatefulWidget {
  const AppleMusicLyricsPage({super.key});

  @override
  State<AppleMusicLyricsPage> createState() => _AppleMusicLyricsPageState();
}

class _AppleMusicLyricsPageState extends State<AppleMusicLyricsPage>
    with TickerProviderStateMixin {
  // Playback state
  bool _isPlaying = true;
  int _currentSec = 30; // start somewhere in the middle for demo
  int _activeLyricIndex = 0;
  bool _isFavorite = false;

  // Volume
  double _volume = 0.65;

  // Toast
  bool _showToast = false;
  String _toastText = '';
  Timer? _toastTimer;

  // Playback timer
  Timer? _playbackTimer;

  // Scroll
  final ScrollController _scrollController = ScrollController();

  // Item keys for scrolling
  final List<GlobalKey> _lyricKeys =
      List.generate(_lyrics.length, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _updateActiveLyric();
    if (_isPlaying) _startTimer();
  }

  @override
  void dispose() {
    _playbackTimer?.cancel();
    _toastTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _playbackTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_currentSec < _totalDurationSec) {
        setState(() {
          _currentSec++;
          _updateActiveLyric();
        });
        _scrollToActiveLyric();
      } else {
        _playbackTimer?.cancel();
        setState(() => _isPlaying = false);
      }
    });
  }

  void _updateActiveLyric() {
    for (int i = _lyrics.length - 1; i >= 0; i--) {
      if (_currentSec >= _lyrics[i].startSec) {
        if (_activeLyricIndex != i) {
          _activeLyricIndex = i;
        }
        break;
      }
    }
  }

  void _scrollToActiveLyric() {
    final key = _lyricKeys[_activeLyricIndex];
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0.35,
      );
    }
  }

  void _togglePlayback() {
    setState(() => _isPlaying = !_isPlaying);
    if (_isPlaying) {
      _startTimer();
    } else {
      _playbackTimer?.cancel();
    }
  }

  void _seekToLyric(int index) {
    _playbackTimer?.cancel();
    setState(() {
      _currentSec = _lyrics[index].startSec;
      _activeLyricIndex = index;
    });
    if (_isPlaying) _startTimer();
    _showToastMessage('Jumped to "${_lyrics[index].text.split('\n').first}..."');
  }

  void _showToastMessage(String msg) {
    _toastTimer?.cancel();
    setState(() {
      _toastText = msg;
      _showToast = true;
    });
    _toastTimer = Timer(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _showToast = false);
    });
  }

  String _formatTime(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  String _formatRemaining(int sec) {
    final rem = _totalDurationSec - sec;
    final m = rem ~/ 60;
    final s = rem % 60;
    return '-$m:${s.toString().padLeft(2, '0')}';
  }

  // ── Colors ────────────────────────────────────────────────────────────────
  static const Color _bgColor = Color(0xFF0D0D11);
  static const Color _surfaceContainerLowest = Color(0xFF0E0E12);
  static const Color _surfaceContainerHigh = Color(0xFF2A292E);
  static const Color _onSurface = Color(0xFFE4E1E7);
  static const Color _onSurfaceVariant = Color(0xFFE6BDBC);
  static const Color _primary = Color(0xFFFFB3B2);
  static const Color _secondaryContainer = Color(0xFFD00242);
  static const Color _primaryContainer = Color(0xFFFF525E);
  static const Color _tertiaryContainer = Color(0xFFFF5354);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ── Ambient glow blobs ───────────────────────────────────────────
          _buildAmbientGlows(),

          // ── Main column ──────────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: _buildLyricsStream(),
                ),
              ],
            ),
          ),

          // ── Footer controls ──────────────────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildFooter(),
          ),

          // ── Toast overlay ────────────────────────────────────────────────
          _buildToast(),
        ],
      ),
    );
  }

  // ── Ambient background glows ─────────────────────────────────────────────
  Widget _buildAmbientGlows() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: -MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.05,
              child: _GlowBlob(
                size: MediaQuery.of(context).size.width * 0.85,
                color: _secondaryContainer.withValues(alpha: 0.30),
                blurRadius: 105,
                animDuration: const Duration(seconds: 7),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.30,
              right: -MediaQuery.of(context).size.width * 0.15,
              child: _GlowBlob(
                size: MediaQuery.of(context).size.width * 0.90,
                color: _primaryContainer.withValues(alpha: 0.20),
                blurRadius: 115,
                animDuration: const Duration(seconds: 9),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.20,
              left: -MediaQuery.of(context).size.width * 0.10,
              child: _GlowBlob(
                size: MediaQuery.of(context).size.width * 0.80,
                color: _tertiaryContainer.withValues(alpha: 0.22),
                blurRadius: 95,
                animDuration: const Duration(seconds: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF131317).withValues(alpha: 0.40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Drag indicator pill
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: _onSurface.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          Row(
            children: [
              // Back button
              _IconBtn(
                icon: Icons.keyboard_arrow_down_rounded,
                size: 28,
                onTap: () {},
              ),
              // Title + subtitle
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Merry Christmas, Please Don\'t Call',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _onSurface,
                        letterSpacing: -0.3,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      'Now Playing',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: _onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              // More options + avatar
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _IconBtn(
                    icon: Icons.more_horiz,
                    size: 22,
                    onTap: () {},
                  ),
                  const SizedBox(width: 4),
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: _surfaceContainerHigh,
                    child: const Icon(Icons.person, color: Colors.white54, size: 16),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Lyrics scroll area ────────────────────────────────────────────────────
  Widget _buildLyricsStream() {
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 280),
      children: [
        // Track identity card
        _buildTrackCard(),
        const SizedBox(height: 20),
        // Lyric lines
        ..._buildLyricLines(),
      ],
    );
  }

  // ── Track identity card ───────────────────────────────────────────────────
  Widget _buildTrackCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F23).withValues(alpha: 0.60),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.40),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Album art
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF8B0000),
                    Color(0xFF2D0A1E),
                    Color(0xFF1A0A2E),
                  ],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Simulated album cover texture
                  const Icon(Icons.album, color: Colors.white24, size: 32),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Track info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Merry Christmas, Please Don\'t Call',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _onSurface,
                    letterSpacing: -0.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Bleachers',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: _onSurfaceVariant.withValues(alpha: 0.85),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: _onSurfaceVariant.withValues(alpha: 0.40),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    _Badge(text: 'LOSSLESS'),
                    const SizedBox(width: 4),
                    _Badge(text: 'DOLBY ATMOS'),
                  ],
                ),
              ],
            ),
          ),
          // Actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => setState(() => _isFavorite = !_isFavorite),
                child: Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  child: Icon(
                    _isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
                    color: _primary,
                    size: 22,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.more_horiz,
                    color: _onSurfaceVariant,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Individual lyric lines ─────────────────────────────────────────────────
  List<Widget> _buildLyricLines() {
    return List.generate(_lyrics.length, (i) {
      final isActive = i == _activeLyricIndex;
      final isPast = i < _activeLyricIndex;
      final distanceFromActive = (i - _activeLyricIndex).abs();

      // Opacity based on distance
      double opacity;
      if (isActive) {
        opacity = 1.0;
      } else if (isPast) {
        opacity = distanceFromActive == 1 ? 0.55 : 0.40;
      } else {
        // upcoming
        if (distanceFromActive == 1) {
          opacity = 0.45;
        } else if (distanceFromActive == 2) {
          opacity = 0.35;
        } else if (distanceFromActive == 3) {
          opacity = 0.20;
        } else {
          opacity = 0.15;
        }
      }

      return GestureDetector(
        key: _lyricKeys[i],
        onTap: () => _seekToLyric(i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: const Cubic(0.2, 0.8, 0.2, 1.0),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          margin: isActive ? const EdgeInsets.symmetric(vertical: 4) : EdgeInsets.zero,
          decoration: isActive
              ? BoxDecoration(
                  color: _surfaceContainerHigh.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(12),
                )
              : null,
          child: AnimatedScale(
            scale: isActive ? 1.02 : 1.0,
            duration: const Duration(milliseconds: 350),
            alignment: Alignment.centerLeft,
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 350),
              child: _buildLyricText(i, isActive),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildLyricText(int i, bool isActive) {
    final line = _lyrics[i];
    return Text(
      line.text,
      style: TextStyle(
        fontSize: isActive ? 26 : 24,
        fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
        color: _onSurface,
        height: isActive ? 1.35 : 1.32,
        letterSpacing: isActive ? -0.5 : -0.3,
        shadows: isActive
            ? [
                Shadow(
                  color: Colors.white.withValues(alpha: 0.35),
                  blurRadius: 24,
                ),
              ]
            : null,
      ),
    );
  }

  // ── Footer ────────────────────────────────────────────────────────────────
  Widget _buildFooter() {
    final progress = _currentSec / _totalDurationSec;

    return Container(
      decoration: BoxDecoration(
        color: _surfaceContainerLowest.withValues(alpha: 0.80),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.40),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Progress bar
              _buildProgressBar(progress),
              const SizedBox(height: 4),
              // Time labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatTime(_currentSec),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: _onSurfaceVariant,
                    ),
                  ),
                  Text(
                    _formatRemaining(_currentSec),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: _onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Transport controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _IconBtn(
                    icon: Icons.skip_previous_rounded,
                    size: 34,
                    onTap: () {
                      _playbackTimer?.cancel();
                      setState(() {
                        _currentSec = 0;
                        _activeLyricIndex = 0;
                      });
                      if (_isPlaying) _startTimer();
                    },
                  ),
                  const SizedBox(width: 36),
                  // Play / Pause large button
                  GestureDetector(
                    onTap: _togglePlayback,
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: _onSurface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.30),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        color: _bgColor,
                        size: 38,
                      ),
                    ),
                  ),
                  const SizedBox(width: 36),
                  _IconBtn(
                    icon: Icons.skip_next_rounded,
                    size: 34,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Volume slider
              Row(
                children: [
                  Icon(Icons.volume_mute_rounded, color: _onSurfaceVariant, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildVolumeSlider(),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.volume_up_rounded, color: _onSurfaceVariant, size: 20),
                ],
              ),
              const SizedBox(height: 8),
              // Bottom action nav
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavBtn(
                    icon: Icons.chat_bubble_rounded,
                    isActive: true,
                    label: 'Lyrics',
                    onTap: () {},
                  ),
                  _NavBtn(
                    icon: Icons.airplay_rounded,
                    isActive: false,
                    label: 'AirPlay',
                    onTap: () {},
                  ),
                  _NavBtn(
                    icon: Icons.queue_music_rounded,
                    isActive: false,
                    label: 'Up Next',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final box = context.findRenderObject() as RenderBox;
        final localPos = box.globalToLocal(details.globalPosition);
        final newProgress =
            (localPos.dx / box.size.width).clamp(0.0, 1.0);
        _playbackTimer?.cancel();
        setState(() {
          _currentSec = (newProgress * _totalDurationSec).toInt();
          _updateActiveLyric();
        });
        if (_isPlaying) _startTimer();
      },
      child: Container(
        width: double.infinity,
        height: 20,
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Track
            Container(
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            // Elapsed
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                  color: _onSurface,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVolumeSlider() {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final box = context.findRenderObject() as RenderBox;
        final trackWidth = box.size.width - 56; // subtract icon widths
        final localPos = box.globalToLocal(details.globalPosition);
        setState(() {
          _volume = ((localPos.dx - 28) / trackWidth).clamp(0.0, 1.0);
        });
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          FractionallySizedBox(
            widthFactor: _volume,
            child: Container(
              height: 5,
              decoration: BoxDecoration(
                color: _onSurface,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Toast ─────────────────────────────────────────────────────────────────
  Widget _buildToast() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      top: _showToast ? 80 : 60,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: _showToast ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 280),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _surfaceContainerHigh.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(99),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.30),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sync_rounded, color: _primary, size: 16),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    _toastText,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _onSurface,
                      letterSpacing: 0.2,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Reusable widgets ──────────────────────────────────────────────────────────

class _GlowBlob extends StatefulWidget {
  final double size;
  final Color color;
  final double blurRadius;
  final Duration animDuration;

  const _GlowBlob({
    required this.size,
    required this.color,
    required this.blurRadius,
    required this.animDuration,
  });

  @override
  State<_GlowBlob> createState() => _GlowBlobState();
}

class _GlowBlobState extends State<_GlowBlob>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.animDuration)
      ..repeat(reverse: true);
    _scaleAnim = Tween(begin: 0.90, end: 1.10).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child2) => Transform.scale(
        scale: _scaleAnim.value,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
            boxShadow: [
              BoxShadow(
                color: widget.color,
                blurRadius: widget.blurRadius,
                spreadRadius: widget.blurRadius * 0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;

  const _IconBtn({
    required this.icon,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white.withValues(alpha: 0.85), size: size),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  const _Badge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF353439).withValues(alpha: 0.80),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE4E1E7),
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final String label;
  final VoidCallback onTap;

  const _NavBtn({
    required this.icon,
    required this.isActive,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isActive
              ? Colors.white.withValues(alpha: 0.20)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: isActive
              ? Colors.white.withValues(alpha: 0.95)
              : Colors.white.withValues(alpha: 0.54),
          size: 22,
        ),
      ),
    );
  }
}
