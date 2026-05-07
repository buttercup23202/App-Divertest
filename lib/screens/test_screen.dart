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
      'id': 'P1',
      'title': 'La mesa',
      'description': 'Frente a ti hay una mesa con tres objetos: un cuchillo, un libro y una mano extendida.',
      'question': '¿Qué haces?',
      'timeLimit': 15,
      'options': [
        {'text': 'Tomo el cuchillo', 'description': 'Instinto de defensa y poder', 'factionPoints': {'Osadía': 4}, 'color': Color(0xFFD85A30)},
        {'text': 'Tomo el libro', 'description': 'Instinto de conocer antes de actuar', 'factionPoints': {'Erudición': 4}, 'color': Color(0xFF185FA5)},
        {'text': 'Tomo la mano', 'description': 'Confiar en otro como primer acto', 'factionPoints': {'Amabilidad': 3, 'Abnegación': 2}, 'color': Color(0xFF3B6D11)},
        {'text': 'No tomo nada, observo', 'description': 'Observar primero, sin comprometerse', 'factionPoints': {'Verdad': 3, 'Erudición': 1}, 'color': Color(0xFF534AB7)},
      ],
    },
    {
      'id': 'P2a',
      'title': 'El perro',
      'description': 'Caminas por una calle oscura y te encuentras con un perro grande, agresivo, que te bloquea el paso.',
      'question': '¿Cómo actúas?',
      'timeLimit': 15,
      'options': [
        {'text': 'Lo enfrento directamente', 'description': 'Mostrar valor ante el peligro', 'factionPoints': {'Osadía': 4}, 'color': Color(0xFFD85A30)},
        {'text': 'Intento calmarlo con calma', 'description': 'Empatía y control emocional', 'factionPoints': {'Amabilidad': 3}, 'color': Color(0xFF3B6D11)},
        {'text': 'Protejo a quienes están conmigo', 'description': 'Sacrificio por los demás', 'factionPoints': {'Abnegación': 4}, 'color': Color(0xFF9E9B94)},
        {'text': 'Busco una ruta alternativa', 'description': 'Evitación estratégica', 'factionPoints': {'Erudición': 2, 'Verdad': 1}, 'color': Color(0xFF185FA5)},
      ],
    },
    {
      'id': 'P3a',
      'title': '5 vs 1',
      'description': 'Tienes que elegir entre salvar a cinco desconocidos o salvar a una persona que conoces y amas.',
      'question': '¿Qué decides?',
      'timeLimit': 15,
      'options': [
        {'text': 'Salvo a los cinco', 'description': 'El bien común por encima de todo', 'factionPoints': {'Erudición': 3, 'Abnegación': 2}, 'color': Color(0xFF185FA5)},
        {'text': 'Salvo al conocido', 'description': 'La lealtad personal es más importante', 'factionPoints': {'Amabilidad': 3, 'Osadía': 1}, 'color': Color(0xFF3B6D11)},
        {'text': 'Intento salvar a todos', 'description': 'No acepto límites, busco otra solución', 'factionPoints': {'Osadía': 3, 'Divergente': 2}, 'color': Color(0xFFD85A30)},
        {'text': 'Me paralizo, no puedo decidir', 'description': 'La verdad me abruma', 'factionPoints': {'Verdad': 3, 'Amabilidad': 1}, 'color': Color(0xFF534AB7)},
      ],
    },
    {
      'id': 'P3b',
      'title': 'El espejo',
      'description': 'Te enfrentas a un espejo que refleja una versión perfecta de ti mismo.',
      'question': '¿Qué haces?',
      'timeLimit': 15,
      'options': [
        {'text': 'Rompo el espejo', 'description': 'Rechazo la perfección falsa', 'factionPoints': {'Osadía': 3, 'Verdad': 2}, 'color': Color(0xFFD85A30)},
        {'text': 'Estudio el espejo', 'description': 'Intento entender cómo funciona', 'factionPoints': {'Erudición': 4}, 'color': Color(0xFF185FA5)},
        {'text': 'Rechazo la imagen', 'description': 'Prefiero mis imperfecciones reales', 'factionPoints': {'Abnegación': 4, 'Verdad': 1}, 'color': Color(0xFF9E9B94)},
        {'text': 'Pregunto si es real', 'description': 'Busco la verdad antes de actuar', 'factionPoints': {'Verdad': 4}, 'color': Color(0xFF534AB7)},
      ],
    },
    {
      'id': 'P3c',
      'title': 'El fuego',
      'description': 'Un incendio se desata. La gente entra en pánico y todos miran hacia ti.',
      'question': '¿Cómo lideras la crisis?',
      'timeLimit': 15,
      'options': [
        {'text': 'Lidero con firmeza', 'description': 'Tomo el control y doy órdenes claras', 'factionPoints': {'Osadía': 4, 'Abnegación': 1}, 'color': Color(0xFFD85A30)},
        {'text': 'Diseño un plan estratégico', 'description': 'Analizo y busco la mejor ruta', 'factionPoints': {'Erudición': 4}, 'color': Color(0xFF185FA5)},
        {'text': 'Ayudo a los vulnerables', 'description': 'Me aseguro de que los débiles salgan primero', 'factionPoints': {'Abnegación': 3, 'Amabilidad': 3}, 'color': Color(0xFF9E9B94)},
        {'text': 'Busco una salida para todos', 'description': 'Investigo todas las opciones', 'factionPoints': {'Erudición': 3, 'Osadía': 2}, 'color': Color(0xFF185FA5)},
      ],
    },
  ];

  Map<String, dynamic> get currentQuestionData => questions[currentQuestion - 1];
  
  Color get currentFactionColor {
    final options = currentQuestionData['options'] as List;
    for (var option in options) {
      final points = option['factionPoints'] as Map<String, int>;
      if (points.containsKey('Osadía')) return const Color(0xFFD85A30);
      if (points.containsKey('Erudición')) return const Color(0xFF185FA5);
      if (points.containsKey('Amabilidad')) return const Color(0xFF3B6D11);
      if (points.containsKey('Abnegación')) return const Color(0xFF9E9B94);
      if (points.containsKey('Verdad')) return const Color(0xFF534AB7);
    }
    return const Color(0xFF185FA5);
  }

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
    _isAnswered = true;
    _timer?.cancel();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('⏰ Tiempo agotado'), backgroundColor: Color(0xFFD85A30), duration: Duration(seconds: 1)),
    );
    Future.delayed(const Duration(seconds: 1), () => _nextOrResults());
  }

  void _selectOption(int index) {
    if (_isAnswered) return;
    final option = currentQuestionData['options'][index];
    final points = option['factionPoints'] as Map<String, int>;
    setState(() {
      selectedOption = index;
      _isAnswered = true;
      _timer?.cancel();
      points.forEach((faction, value) => totalPoints[faction] = (totalPoints[faction] ?? 0) + value);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('✓ Respuesta guardada'), backgroundColor: option['color'], duration: const Duration(milliseconds: 800)),
    );
    Future.delayed(const Duration(milliseconds: 800), () => _nextOrResults());
  }

  void _nextOrResults() {
    if (currentQuestion < totalQuestions) {
      setState(() {
        currentQuestion++;
        selectedOption = -1;
        _isAnswered = false;
      });
      _startTimer();
    } else {
      _showResults();
    }
  }

  void _showResults() {
    final filteredPoints = Map.fromEntries(totalPoints.entries.where((e) => e.value > 0));
    final sorted = filteredPoints.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final topFaction = sorted.isNotEmpty ? sorted.first.key : 'Divergente';
    final topScore = sorted.isNotEmpty ? sorted.first.value : 0;
    final secondScore = sorted.length > 1 ? sorted[1].value : 0;
    final highScores = totalPoints.values.where((s) => s >= 6).length;
    final isDivergent = highScores >= 2 || (secondScore > 0 && topScore - secondScore < 3) || topFaction == 'Divergente';
    final finalFaction = isDivergent ? 'Divergente' : topFaction;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: const Color(0xFF111E2B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: BorderSide(color: isDivergent ? const Color(0xFFC0A060) : _getFactionColor(topFaction), width: 2)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isDivergent ? Icons.all_inclusive : Icons.verified, size: 60, color: isDivergent ? const Color(0xFFC0A060) : _getFactionColor(topFaction)),
              const SizedBox(height: 20),
              Text(isDivergent ? '¡ERES DIVERGENTE!' : 'PERTENECES A', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2, color: isDivergent ? const Color(0xFFC0A060) : Colors.white)),
              const SizedBox(height: 16),
              Text(finalFaction, textAlign: TextAlign.center, style: TextStyle(fontSize: finalFaction == 'Divergente' ? 28 : 36, fontWeight: FontWeight.bold, color: _getFactionColor(finalFaction), fontFamily: 'Georgia')),
              if (isDivergent && topFaction != 'Divergente') ...[
                const SizedBox(height: 8),
                Text('Afinidad principal: $topFaction', style: const TextStyle(fontSize: 12, color: Color(0xFF8899AA))),
              ],
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
    final dominantColor = currentFactionColor;

    return Scaffold(
      backgroundColor: const Color(0xFF080F1A),
      body: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: TestBackgroundPainter(dominantColor: dominantColor),
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
                        onTap: _isAnswered ? null : () { _timer?.cancel(); Navigator.pop(context); },
                        child: Icon(Icons.arrow_back_ios_rounded, size: 18, color: _isAnswered ? Colors.white24 : const Color(0x61FFFFFF)),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(border: Border.all(color: Colors.white10), borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            const Icon(Icons.auto_awesome, size: 10, color: Color(0x4DFFFFFF)),
                            const SizedBox(width: 6),
                            Text('TEST DE APTITUD', style: TextStyle(fontSize: 10, letterSpacing: 4, fontWeight: FontWeight.w400, color: const Color(0x66FFFFFF), fontFamily: 'Georgia')),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: _timeRemaining < 5 ? const Color(0xFFD85A30) : Colors.white24, width: 2)),
                        child: Center(child: Text('$_timeRemaining', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _timeRemaining < 5 ? const Color(0xFFD85A30) : Colors.white))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Text('0${currentQuestion}', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w800, color: Colors.white.withOpacity(0.08), fontFamily: 'Georgia')),
                          Text('PREGUNTA $currentQuestion DE $totalQuestions', style: const TextStyle(fontSize: 10, letterSpacing: 3, color: Color(0x59FFFFFF))),
                        ],
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: currentQuestion / totalQuestions,
                        backgroundColor: Colors.white10,
                        valueColor: AlwaysStoppedAnimation(dominantColor),
                        minHeight: 3,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(question['title'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Georgia')),
                      const SizedBox(height: 12),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Container(width: 30, height: 1, color: Colors.white24),
                        const SizedBox(width: 8),
                        Text('◆', style: TextStyle(fontSize: 8, color: Colors.white38)),
                        const SizedBox(width: 8),
                        Container(width: 30, height: 1, color: Colors.white24),
                      ]),
                      const SizedBox(height: 12),
                      Text(question['description'], style: const TextStyle(fontSize: 14, color: Color(0xFF8899AA), height: 1.7), textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      Text(question['question'], style: TextStyle(fontSize: 13, letterSpacing: 2, color: Colors.white54, fontFamily: 'Georgia')),
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
                            color: isSelected ? optColor.withOpacity(0.15) : const Color(0xFF0D1820),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: isSelected ? optColor : Colors.white.withOpacity(0.1), width: isSelected ? 1.5 : 1),
                            boxShadow: isSelected ? [BoxShadow(color: optColor.withOpacity(0.3), blurRadius: 16, spreadRadius: -2)] : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 22, height: 22,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: isSelected ? optColor : Colors.white24, width: 1.5),
                                    color: isSelected ? optColor : Colors.transparent,
                                  ),
                                  child: isSelected ? const Icon(Icons.check_rounded, size: 14, color: Colors.white) : null,
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(option['text'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: isSelected ? optColor : Colors.white)),
                                      const SizedBox(height: 4),
                                      Text(option['description'], style: const TextStyle(fontSize: 12, color: Color(0xFF6A7A8A))),
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
                AnimatedOpacity(
                  opacity: selectedOption != -1 ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                    child: GestureDetector(
                      onTap: _nextOrResults,
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF1A3050), Color(0xFF0D1E30)]),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
                          boxShadow: [BoxShadow(color: const Color(0xFF185FA5).withOpacity(0.2), blurRadius: 20)],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.hexagon_outlined, size: 16, color: Color(0x4DFFFFFF)),
                            SizedBox(width: 8),
                            Text('SIGUIENTE', style: TextStyle(fontSize: 13, letterSpacing: 3, color: Colors.white)),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_rounded, size: 16, color: Color(0x80FFFFFF)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TestBackgroundPainter extends CustomPainter {
  final Color dominantColor;
  TestBackgroundPainter({required this.dominantColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 140.0);
    paint.color = dominantColor.withOpacity(0.15);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.2), 180, paint);
    paint.color = const Color(0xFF534AB7).withOpacity(0.10);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.5), 150, paint);
    paint.color = const Color(0xFFD85A30).withOpacity(0.08);
    canvas.drawCircle(Offset(size.width * 0.5, size.height), 160, paint);
  }

  @override
  bool shouldRepaint(covariant TestBackgroundPainter oldDelegate) => false;
}