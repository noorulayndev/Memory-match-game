import 'package:flutter/material.dart';
import '../models/card_model.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  final List<Color> cardColors = [
    const Color(0xFF98FB98), // lime green
    const Color(0xFFDDA0DD), // soft purple
    const Color(0xFFFFB6C1), // bright pink
    const Color(0xFFFFB347), // orange
    const Color(0xFF40E0D0), // teal
  ];

  List<MemoryCard> cards = [];
  MemoryCard? firstSelectedCard;
  int matchesFound = 0;
  bool isProcessing = false;
  late List<AnimationController> _flipControllers;
  late List<Animation<double>> _flipAnimations;

  @override
  void dispose() {
    for (var controller in _flipControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    List<String> imagePaths = [
      'assets/images/1.jpg',
      'assets/images/2.jpg',
      'assets/images/3.jpg',
      'assets/images/4.jpg',
      'assets/images/5.jpg',
      'assets/images/6.jpg',
      'assets/images/7.jpg',
      'assets/images/8.jpg',
      'assets/images/9.jpg',
      'assets/images/10.jpg',
    ];

    List<String> allPaths = [...imagePaths, ...imagePaths];
    allPaths.shuffle();

    cards = List.generate(20, (index) {
      return MemoryCard(
        id: index,
        imagePath: allPaths[index],
      );
    });

    _flipControllers = List.generate(20, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
    });

    _flipAnimations = _flipControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    setState(() {
      firstSelectedCard = null;
      matchesFound = 0;
      isProcessing = false;
    });
  }

  void _onCardTapped(int index) {
    if (isProcessing || cards[index].isFaceUp || cards[index].isMatched) {
      return;
    }

    setState(() {
      cards[index].isFaceUp = true;
    });
    _flipControllers[index].forward();

    if (firstSelectedCard == null) {
      firstSelectedCard = cards[index];
    } else {
      if (firstSelectedCard!.imagePath == cards[index].imagePath) {
        setState(() {
          firstSelectedCard!.isMatched = true;
          cards[index].isMatched = true;
          matchesFound++;
          firstSelectedCard = null;
        });
      } else {
        setState(() {
          isProcessing = true;
        });

        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            firstSelectedCard!.isFaceUp = false;
            cards[index].isFaceUp = false;
            firstSelectedCard = null;
            isProcessing = false;
          });
          _flipControllers[firstSelectedCard!.id].reverse();
          _flipControllers[index].reverse();
        });
      }
    }
  }

  void _restartGame() {
    for (var controller in _flipControllers) {
      controller.reset();
    }
    _initializeGame();
  }

  Widget _buildCardContent(MemoryCard card, int index) {
    if (card.isFaceUp || card.isMatched) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: card.isMatched ? const Color(0xFF4CAF50) : const Color(0xFFE0E0E0),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Opacity(
                  opacity: card.isMatched ? 0.7 : 1.0,
                  child: Image.asset(
                    card.imagePath,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.pets,
                        size: 40,
                        color: Color(0xFF4A148C),
                      );
                    },
                  ),
                ),
              ),
            ),
            if (card.isMatched)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cardColors[index % cardColors.length],
              cardColors[index % cardColors.length].withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            '?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAE8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFAE8),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Memory Match',
          style: TextStyle(
            color: Color(0xFF4A148C),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.white, Color(0xFFF8F8FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF4A148C).withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A148C).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: Color(0xFF4A148C),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$matchesFound',
                  style: const TextStyle(
                    color: Color(0xFF4A148C),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Find all matching pairs! 🐾',
              style: TextStyle(
                color: Color(0xFF6A4C93),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth;
                  int crossAxisCount = screenWidth > 600 ? 5 : 4;
                  double aspectRatio = screenWidth > 600 ? 0.8 : 0.75;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: aspectRatio,
                    ),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return GestureDetector(
                        onTap: () => _onCardTapped(index),
                        child: AnimatedBuilder(
                          animation: _flipAnimations[index],
                          builder: (context, child) {
                            final isShowingFront = _flipAnimations[index].value < 0.5;
                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(_flipAnimations[index].value * 3.14159),
                              child: isShowingFront
                                  ? _buildCardContent(card, index)
                                  : Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.identity()..rotateY(3.14159),
                                      child: _buildCardContent(card, index),
                                    ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A4C93), Color(0xFF4A148C)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A148C).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _restartGame,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.refresh_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Restart',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}