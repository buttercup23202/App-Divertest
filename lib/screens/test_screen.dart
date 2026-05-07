import 'dart:async';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int selectedOption = -1;
  int currentQuestion = 1;
  final int totalQuestions = 5;
  
  Timer? _timer;
  int _timeRemaining = 15;
  bool _isAnswered = false;
  
  Map<String, int> totalPoints = {
    'Osadía': 0,
    'Erudición': 0,
    'Abnegación': 0,
    'Verdad': 0,
    'Amabilidad': 0,
    'Divergente': 0,
  };

  final List<Map<String, dynamic>> questions = [
    {
      'title': 'La mesa',
      'description': 'Frente a ti hay una mesa con tres objetos: un cuchillo, un libro y una mano extendida.',
      'question': '¿Qué haces?',
      'timeLimit': 15,
      'options': [
        {'text': 'Tomo el cuchillo', 'desc': 'Instinto de defensa', 'points': {'Osadía': 4}, 'color': Color(0xFFD85A30)},
        {'text': 'Tomo el libro', 'desc': 'Instinto de conocimiento', 'points': {'Erudición': 4}, 'color': Color(0xFF185FA5)},
        {'text': 'Tomo la mano', 'desc': 'Confiar en otros', 'points': {'Amabilidad': 3, 'Abnegación': 2}, 'color': Color(0xFF3B6D11)},
        {'text': 'Observo primero', 'desc': 'Análisis sin acción', 'points': {'Verdad': 3, 'Erudición': 1}, 'color': Color(0xFF534AB7)},
      ],
    },
    {
      'title': 'El perro',
      'description': 'Te encuentras con un perro grande y agresivo que te bloquea el paso.',
      'question': '¿Cómo actúas?',
      'timeLimit': 15,
      'options': [
        {'text': 'Lo enfrento', 'desc': 'Valor ante el peligro', 'points': {'Osadía': 4}, 'color': Color(0xFFD85A30)},
        {'text': 'Lo calmo', 'desc': 'Empatía y control', 'points': {'Amabilidad': 3}, 'color': Color(0xFF3B6D11)},
        {'text': 'Protejo a otros', 'desc': 'Sacrificio por los demás', 'points': {'Abnegación': 4}, 'color': Color(0xFF9E9B94)},
        {'text': 'Busco alternativa', 'desc': 'Evitación estratégica', 'points': {'Erudición': 2, 'Verdad': 1}, 'color': Color(0xFF185FA5)},
      ],
    },
    {
      'title': '5 vs 1',
      'description': 'Debes elegir entre salvar a cinco desconocidos o a un ser querido.',
      'question': '¿Qué decides?',
      'timeLimit': 15,
      'options': [
        {'text': 'Salvo a los cinco', 'desc': 'Bien común', 'points': {'Erudición': 3, 'Abnegación': 2}, 'color': Color(0xFF185FA5)},
        {'text': 'Salvo al conocido', 'desc': 'Lealtad personal', 'points': {'Amabilidad': 3, 'Osadía': 1}, 'color': Color(0xFF3B6D11)},
        {'text': 'Intento salvar a todos', 'desc': 'No acepto límites', 'points': {'Osadía': 3, 'Divergente': 2}, 'color': Color(0xFFD85A30)},
        {'text': 'No puedo decidir', 'desc': 'La verdad me abruma', 'points': {'Verdad': 3}, 'color': Color(0xFF534AB7)},
      ],
    },
    {
      'title': 'El espejo',
      'description': 'Un espejo muestra una versión perfecta de ti mismo.',
      'question': '¿Qué haces?',
      'timeLimit': 15,
      'options': [
        {'text': 'Rompo el espejo', 'desc': 'Rechazo la falsa perfección', 'points': {'Osadía': 3, 'Verdad': 2}, 'color': Color(0xFFD85A30)},
        {'text': 'Estudio el espejo', 'desc': 'Busco entender', 'points': {'Erudición': 4}, 'color': Color(0xFF185FA5)},
        {'text': 'Rechazo la imagen', 'desc': 'Prefiero mis imperfecciones', 'points': {'Abnegación': 4}, 'color': Color(0xFF9E9B94)},
        {'text': 'Pregunto si es real', 'desc': 'Busco la verdad', 'points': {'Verdad': 4}, 'color': Color(0xFF534AB7)},
      ],
    },
    {
      'title': 'El fuego',
      'description': 'Un incendio se desata. La gente entra en pánico y te mira.',
      'question': '¿Cómo lideras?',
      'timeLimit': 15,
      'options': [
        {'text': 'Lidero con firmeza', 'desc': 'Control y orden', 'points': {'Osadía': 4}, 'color': Color(0xFFD85A30)},
        {'text': 'Diseño un plan', 'desc': 'Estrategia', 'points': {'Erudición': 4}, 'color': Color(0xFF185FA5)},
        {'text': 'Ayudo a los débiles', 'desc': 'Protección', 'points': {'Abnegación': 3, 'Amabilidad': 3}, 'color': Color(0xFF9E9B94)},
        {'text': 'Busco salida para todos', 'desc': 'Soluciones', 'points': {'Erudición': 3, 'Osadía': 2}, 'color': Color(0xFF185FA5)},
      ],
    },
  ];

  Map<String, dynamic> get currentQuestionData => questions[currentQuestion - 1];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timeRemaining = currentQuestionData['timeLimit'];
    _isAnswered = false;
    selectedOption = -1;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining <= 0 && !_isAnswered) {
        timer.cancel();
        _autoSelectNext();
      } else if (!_isAnswered) {
        setState(() => _timeRemaining--);
      }
    });
  }

  void _autoSelectNext() {
    if (_isAnswered) return;
    _isAnswered = true;
    _timer?.cancel();
    
    if (currentQuestion < totalQuestions) {
      Future.delayed(const Duration(milliseconds: 500), () => _goToNextQuestion());
    } else {
      Future.delayed(const Duration(milliseconds: 500), () => _showResults());
    }
  }

  void _selectOption(int index) {
    if (_isAnswered) return;
    final option = currentQuestionData['options'][index];
    final points = option['points'] as Map<String, int>;
    
    setState(() {
      selectedOption = index;
      _isAnswered = true;
      _timer?.cancel();
      points.forEach((faction, value) {
        totalPoints[faction] = (totalPoints[faction] ?? 0) + value;
      });
    });
    
    // Avance automático después de 1 segundo
    Future.delayed(const Duration(milliseconds: 800), () {
      if (currentQuestion < totalQuestions) {
        _goToNextQuestion();
      } else {
        _showResults();
      }
    });
  }

  void _goToNextQuestion() {
    setState(() {
      currentQuestion++;
      selectedOption = -1;
      _isAnswered = false;
    });
    _startTimer();
  }

  void _showResults() {
    final filteredPoints = Map.fromEntries(totalPoints.entries.where((e) => e.value > 0));
    final sorted = filteredPoints.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final topFaction = sorted.isNotEmpty ? sorted.first.key : 'Divergente';
    final topScore = sorted.isNotEmpty ? sorted.first.value : 0;
    final secondScore = sorted.length > 1 ? sorted[1].value : 0;
    final isDivergent = (topScore - secondScore) < 3 || topFaction == 'Divergente';
    final finalFaction = isDivergent ? 'Divergente' : topFaction;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: const Color(0xFF111E2B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: isDivergent ? const Color(0xFFC0A060) : _getFactionColor(topFaction), width: 2),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isDivergent ? Icons.all_inclusive : Icons.verified, size: 60, color: isDivergent ? const Color(0xFFC0A060) : _getFactionColor(topFaction)),
              const SizedBox(height: 20),
              Text(isDivergent ? '¡ERES DIVERGENTE!' : 'PERTENECES A', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2, color: isDivergent ? const Color(0xFFC0A060) : Colors.white)),
              const SizedBox(height: 16),
              Text(finalFaction, textAlign: TextAlign.center, style: TextStyle(fontSize: finalFaction == 'Divergente' ? 28 : 36, fontWeight: FontWeight.bold, color: _getFactionColor(finalFaction))),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDivergent ? const Color(0xFFC0A060) : _getFactionColor(topFaction),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('REINICIAR TEST', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 2, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getFactionColor(String faction) {
    switch (faction) {
      case 'Osadía': return const Color(0xFFD85A30);
      case 'Erudición': return const Color(0xFF185FA5);
      case 'Abnegación': return const Color(0xFF9E9B94);
      case 'Verdad': return const Color(0xFF534AB7);
      case 'Amabilidad': return const Color(0xFF3B6D11);
      case 'Divergente': return const Color(0xFFC0A060);
      default: return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = currentQuestionData;
    final options = question['options'] as List;

    return Scaffold(
      backgroundColor: const Color(0xFF080F1A),
      body: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: TestBackgroundPainter(),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_rounded, size: 18, color: Color(0x61FFFFFF)),
                      ),
                      const Spacer(),
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: _timeRemaining < 5 ? const Color(0xFFD85A30) : Colors.white24, width: 2)),
                        child: Center(child: Text('$_timeRemaining', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _timeRemaining < 5 ? const Color(0xFFD85A30) : Colors.white))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        value: currentQuestion / totalQuestions,
                        backgroundColor: Colors.white10,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF185FA5)),
                        minHeight: 3,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 24),
                      Text(question['title'], style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 2)),
                      const SizedBox(height: 16),
                      Text(question['description'], style: const TextStyle(fontSize: 14, color: Color(0xFF8899AA), height: 1.5), textAlign: TextAlign.center),
                      const SizedBox(height: 20),
                      Container(width: 40, height: 1, color: Colors.white24),
                      const SizedBox(height: 20),
                      Text(question['question'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFFC4D8E8))),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: options.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final option = options[index];
                      final isSelected = selectedOption == index;
                      final optColor = option['color'] as Color;
                      return GestureDetector(
                        onTap: _isAnswered ? null : () => _selectOption(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected ? optColor.withOpacity(0.2) : const Color(0xFF0D1820),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: isSelected ? optColor : Colors.white.withOpacity(0.1), width: isSelected ? 1.5 : 1),
                            boxShadow: isSelected ? [BoxShadow(color: optColor.withOpacity(0.3), blurRadius: 16)] : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Row(
                              children: [
                                Container(
                                  width: 24, height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: isSelected ? optColor : Colors.white24, width: 2),
                                    color: isSelected ? optColor : Colors.transparent,
                                  ),
                                  child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(option['text'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: isSelected ? optColor : Colors.white)),
                                      const SizedBox(height: 4),
                                      Text(option['desc'], style: const TextStyle(fontSize: 12, color: Color(0xFF6A7A8A))),
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
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TestBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 140.0);
    paint.color = const Color(0xFF185FA5).withOpacity(0.15);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.2), 180, paint);
    paint.color = const Color(0xFF534AB7).withOpacity(0.10);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.5), 150, paint);
    paint.color = const Color(0xFFD85A30).withOpacity(0.08);
    canvas.drawCircle(Offset(size.width * 0.5, size.height), 160, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}