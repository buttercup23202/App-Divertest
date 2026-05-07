import 'dart:async';
import 'dart:ui';
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

  void _restartTest() {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  String _getCuteMessage(String faction, bool isDivergent) {
    if (isDivergent) {
      return '🌟 ¡Eres especial! Tu mente brilla en varios mundos 🌟';
    }
    
    switch (faction) {
      case 'Osadía':
        return '⚡ Eres valiente como un rayo. ¡El mundo necesita tu coraje! ⚡';
      case 'Erudición':
        return '📚 Tu sed de conocimiento es infinita. ¡Nunca dejes de aprender! 📚';
      case 'Abnegación':
        return '🤝 Tienes un corazón enorme. Gracias por existir para los demás 🤝';
      case 'Verdad':
        return '⚖️ La honestidad es tu superpoder. ¡Siempre con la verdad! ⚖️';
      case 'Amabilidad':
        return '🌸 La paz te sigue donde vas. Eres luz en la oscuridad 🌸';
      case 'Divergente':
        return '🌈 No cabes en una sola caja. ¡Y eso es hermoso! 🌈';
      default:
        return '✨ Eres único y especial. Sigue así ✨';
    }
  }

  void _showResults() {
    final filteredPoints = Map.fromEntries(totalPoints.entries.where((e) => e.value > 0));
    final sorted = filteredPoints.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final topFaction = sorted.isNotEmpty ? sorted.first.key : 'Divergente';
    final topScore = sorted.isNotEmpty ? sorted.first.value : 0;
    final secondScore = sorted.length > 1 ? sorted[1].value : 0;
    final isDivergent = (topScore - secondScore) < 3 || topFaction == 'Divergente';
    final finalFaction = isDivergent ? 'Divergente' : topFaction;
    final factionColor = _getFactionColor(finalFaction);
    final cuteMessage = _getCuteMessage(finalFaction, isDivergent);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    factionColor.withOpacity(0.3),
                    factionColor.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: factionColor.withOpacity(0.4),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: factionColor.withOpacity(0.3),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 48, 24, 28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                factionColor.withOpacity(0.35),
                                factionColor.withOpacity(0.1),
                              ],
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: factionColor.withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              isDivergent ? Icons.all_inclusive : Icons.verified,
                              size: 34,
                              color: factionColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          isDivergent ? '🌸 ¡ERES DIVERGENTE! 🌸' : '🏠 PERTENECES A',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          finalFaction,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: finalFaction == 'Divergente' ? 26 : 34,
                            fontWeight: FontWeight.bold,
                            color: factionColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: factionColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            cuteMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white70,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _restartTest,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: factionColor.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              '🔄 REINICIAR TEST 🔄',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -12,
              right: -12,
              child: GestureDetector(
                onTap: _restartTest,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: factionColor.withOpacity(0.9),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: factionColor.withOpacity(0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.close, size: 18, color: Colors.white),
                ),
              ),
            ),
          ],
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
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.05),
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                          ),
                          child: const Icon(Icons.arrow_back_ios_rounded, size: 18, color: Color(0x61FFFFFF)),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: _timeRemaining < 5 ? const Color(0xFFD85A30) : Colors.white24, width: 2),
                          color: Colors.white.withOpacity(0.05),
                        ),
                        child: Center(
                          child: Text(
                            '$_timeRemaining',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _timeRemaining < 5 ? const Color(0xFFD85A30) : Colors.white),
                          ),
                        ),
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
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3A5A7A)),
                        minHeight: 3,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        question['title'],
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 2),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.02)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.1), width: 0.5),
                        ),
                        child: Text(
                          question['description'],
                          style: const TextStyle(fontSize: 14, color: Color(0xFF8899AA), height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(width: 40, height: 1, color: Colors.white24),
                      const SizedBox(height: 20),
                      Text(
                        question['question'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
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
                            gradient: LinearGradient(
                              colors: isSelected
                                  ? [optColor.withOpacity(0.2), optColor.withOpacity(0.08)]
                                  : [Colors.white.withOpacity(0.04), Colors.white.withOpacity(0.02)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? optColor.withOpacity(0.4) : Colors.white.withOpacity(0.08),
                              width: isSelected ? 1.2 : 0.8,
                            ),
                            boxShadow: isSelected
                                ? [BoxShadow(color: optColor.withOpacity(0.2), blurRadius: 16, spreadRadius: -2)]
                                : null,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24, height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: isSelected ? optColor : Colors.white24, width: 1.5),
                                        color: isSelected ? optColor : Colors.transparent,
                                      ),
                                      child: isSelected ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            option['text'],
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: isSelected ? optColor : Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            option['desc'],
                                            style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
    paint.color = const Color(0xFF185FA5).withOpacity(0.08);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.2), 180, paint);
    paint.color = const Color(0xFF534AB7).withOpacity(0.06);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.5), 150, paint);
    paint.color = const Color(0xFFD85A30).withOpacity(0.05);
    canvas.drawCircle(Offset(size.width * 0.5, size.height), 160, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}