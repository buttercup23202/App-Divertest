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
  
  // Puntuación acumulada
  Map<String, int> totalPoints = {
    'Osadía': 0,
    'Erudición': 0,
    'Abnegación': 0,
    'Verdad': 0,
    'Amabilidad': 0,
    'Divergente': 0,
  };

  // Banco de preguntas
  final List<Map<String, dynamic>> questions = [
    {
      'id': 'P1',
      'title': 'La mesa',
      'description': 'Frente a ti hay una mesa con tres objetos: un cuchillo, un libro y una mano extendida.',
      'question': '¿Qué haces?',
      'imageIcon': Icons.table_restaurant,
      'timeLimit': 15,
      'options': [
        {
          'text': 'Tomo el cuchillo',
          'description': 'Instinto de defensa y poder',
          'factionPoints': {'Osadía': 4},
          'color': Color(0xFFD85A30),
        },
        {
          'text': 'Tomo el libro',
          'description': 'Instinto de conocer antes de actuar',
          'factionPoints': {'Erudición': 4},
          'color': Color(0xFF185FA5),
        },
        {
          'text': 'Tomo la mano',
          'description': 'Confiar en otro como primer acto',
          'factionPoints': {'Amabilidad': 3, 'Abnegación': 2},
          'color': Color(0xFF3B6D11),
        },
        {
          'text': 'No tomo nada, observo',
          'description': 'Observar primero, sin comprometerse',
          'factionPoints': {'Verdad': 3, 'Erudición': 1},
          'color': Color(0xFF534AB7),
        },
      ],
    },
    {
      'id': 'P2a',
      'title': 'El perro',
      'description': 'Caminas por una calle oscura y te encuentras con un perro grande, agresivo, que te bloquea el paso. No hay salida fácil.',
      'question': '¿Cómo actúas?',
      'imageIcon': Icons.pets,
      'timeLimit': 15,
      'options': [
        {
          'text': 'Lo enfrento directamente',
          'description': 'Mostrar valor ante el peligro',
          'factionPoints': {'Osadía': 4},
          'color': Color(0xFFD85A30),
        },
        {
          'text': 'Intento calmarlo con calma',
          'description': 'Empatía y control emocional',
          'factionPoints': {'Amabilidad': 3},
          'color': Color(0xFF3B6D11),
        },
        {
          'text': 'Protejo a quienes están conmigo',
          'description': 'Sacrificio por los demás',
          'factionPoints': {'Abnegación': 4},
          'color': Color(0xFF9E9B94),
        },
        {
          'text': 'Busco una ruta alternativa',
          'description': 'Evitación estratégica',
          'factionPoints': {'Erudición': 2, 'Verdad': 1},
          'color': Color(0xFF185FA5),
        },
      ],
    },
    {
      'id': 'P3a',
      'title': '5 vs 1',
      'description': 'Una situación extrema. Tienes que elegir entre salvar a cinco desconocidos o salvar a una persona que conoces y amas.',
      'question': '¿Qué decides?',
      'imageIcon': Icons.balance,
      'timeLimit': 15,
      'options': [
        {
          'text': 'Salvo a los cinco',
          'description': 'El bien común por encima de todo',
          'factionPoints': {'Erudición': 3, 'Abnegación': 2},
          'color': Color(0xFF185FA5),
        },
        {
          'text': 'Salvo al conocido',
          'description': 'La lealtad personal es más importante',
          'factionPoints': {'Amabilidad': 3, 'Osadía': 1},
          'color': Color(0xFF3B6D11),
        },
        {
          'text': 'Intento salvar a todos',
          'description': 'No acepto límites, busco otra solución',
          'factionPoints': {'Osadía': 3, 'Divergente': 2},
          'color': Color(0xFFD85A30),
        },
        {
          'text': 'Me paralizo, no puedo decidir',
          'description': 'La verdad me abruma',
          'factionPoints': {'Verdad': 3, 'Amabilidad': 1},
          'color': Color(0xFF534AB7),
        },
      ],
    },
    {
      'id': 'P3b',
      'title': 'El espejo',
      'description': 'Te encuentras frente a un espejo que no refleja quién eres, sino una versión perfecta de ti mismo. La imagen te sonríe, perfecta y sin defectos.',
      'question': '¿Qué haces al ver esa imagen?',
      'imageIcon': Icons.brightness_5,
      'timeLimit': 15,
      'options': [
        {
          'text': 'Rompo el espejo',
          'description': 'Rechazo la perfección falsa',
          'factionPoints': {'Osadía': 3, 'Verdad': 2},
          'color': Color(0xFFD85A30),
        },
        {
          'text': 'Estudio el espejo',
          'description': 'Intento entender cómo funciona',
          'factionPoints': {'Erudición': 4},
          'color': Color(0xFF185FA5),
        },
        {
          'text': 'Rechazo la imagen',
          'description': 'Prefiero mis imperfecciones reales',
          'factionPoints': {'Abnegación': 4, 'Verdad': 1},
          'color': Color(0xFF9E9B94),
        },
        {
          'text': 'Pregunto si es real',
          'description': 'Busco la verdad antes de actuar',
          'factionPoints': {'Verdad': 4},
          'color': Color(0xFF534AB7),
        },
      ],
    },
    {
      'id': 'P3c',
      'title': 'El fuego',
      'description': 'Un incendio se desata en el edificio donde te encuentras. La gente entra en pánico. Todos miran hacia ti esperando una dirección.',
      'question': '¿Cómo lideras en la crisis?',
      'imageIcon': Icons.local_fire_department,
      'timeLimit': 15,
      'options': [
        {
          'text': 'Lidero con firmeza',
          'description': 'Tomo el control y doy órdenes claras',
          'factionPoints': {'Osadía': 4, 'Abnegación': 1},
          'color': Color(0xFFD85A30),
        },
        {
          'text': 'Diseño un plan estratégico',
          'description': 'Analizo la situación y busco la mejor ruta',
          'factionPoints': {'Erudición': 4},
          'color': Color(0xFF185FA5),
        },
        {
          'text': 'Ayudo a los vulnerables',
          'description': 'Me aseguro de que los débiles salgan primero',
          'factionPoints': {'Abnegación': 3, 'Amabilidad': 3},
          'color': Color(0xFF9E9B94),
        },
        {
          'text': 'Busco una salida para todos',
          'description': 'Investigo todas las opciones posibles',
          'factionPoints': {'Erudición': 3, 'Osadía': 2},
          'color': Color(0xFF185FA5),
        },
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
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining <= 0) {
        timer.cancel();
        if (!_isAnswered) {
          _autoSelectNext();
        }
      } else {
        setState(() {
          _timeRemaining--;
        });
      }
    });
  }

  void _autoSelectNext() {
    if (_isAnswered) return;
    _isAnswered = true;
    _timer?.cancel();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('⏰ Tiempo agotado'),
        backgroundColor: Color(0xFFD85A30),
        duration: Duration(seconds: 1),
      ),
    );
    
    Future.delayed(const Duration(seconds: 1), () {
      if (currentQuestion < totalQuestions) {
        _goToNextQuestion();
      } else {
        _showResults();
      }
    });
  }

  void _selectOption(int index) {
    if (_isAnswered) return;
    
    final option = currentQuestionData['options'][index];
    final points = option['factionPoints'] as Map<String, int>;
    final Color optionColor = option['color'] as Color;
    
    setState(() {
      selectedOption = index;
      _isAnswered = true;
      _timer?.cancel();
      
      points.forEach((faction, value) {
        totalPoints[faction] = (totalPoints[faction] ?? 0) + value;
      });
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('✓ Respuesta guardada'),
        backgroundColor: optionColor,
        duration: const Duration(milliseconds: 800),
      ),
    );
    
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
    final filteredPoints = Map.fromEntries(
      totalPoints.entries.where((entry) => entry.value > 0)
    );
    
    final sortedEntries = filteredPoints.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    final topFaction = sortedEntries.isNotEmpty ? sortedEntries.first.key : 'Divergente';
    final topScore = sortedEntries.isNotEmpty ? sortedEntries.first.value : 0;
    final secondScore = sortedEntries.length > 1 ? sortedEntries[1].value : 0;
    
    final highScoresCount = totalPoints.values.where((score) => score >= 6).length;
    final isDivergentByHighScore = highScoresCount >= 2;
    final isDivergentByCloseScore = secondScore > 0 && (topScore - secondScore) < 3;
    final isDivergent = isDivergentByHighScore || isDivergentByCloseScore || topFaction == 'Divergente';
    
    final finalFaction = isDivergent ? 'Divergente' : topFaction;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF111E2B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: isDivergent ? const Color(0xFFC0A060) : _getFactionColor(topFaction),
              width: 2,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isDivergent ? Icons.all_inclusive : Icons.verified,
                  size: 60,
                  color: isDivergent ? const Color(0xFFC0A060) : _getFactionColor(topFaction),
                ),
                const SizedBox(height: 20),
                Text(
                  isDivergent ? '¡ERES DIVERGENTE!' : 'PERTENECES A',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: isDivergent ? const Color(0xFFC0A060) : Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  finalFaction,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: finalFaction == 'Divergente' ? 28 : 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: _getFactionColor(finalFaction),
                  ),
                ),
                if (isDivergent && topFaction != 'Divergente') ...[
                  const SizedBox(height: 8),
                  Text(
                    'Afinidad principal: $topFaction',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8899AA),
                      letterSpacing: 1,
                    ),
                  ),
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
                      backgroundColor: isDivergent 
                          ? const Color(0xFFC0A060) 
                          : _getFactionColor(topFaction),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'REINICIAR TEST',
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
        );
      },
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _isAnswered ? null : () {
                          _timer?.cancel();
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                          color: _isAnswered 
                              ? Colors.white.withOpacity(0.3)
                              : const Color(0xFF7A8FA6),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A2E42),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          'PREGUNTA $currentQuestion DE $totalQuestions',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            color: Color(0xFF8A9BB0),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _timeRemaining < 5
                                ? const Color(0xFFD85A30)
                                : const Color(0xFF185FA5),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '$_timeRemaining',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _timeRemaining < 5
                                  ? const Color(0xFFD85A30)
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: LinearProgressIndicator(
                    value: currentQuestion / totalQuestions,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF185FA5),
                    ),
                    minHeight: 2,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const RadialGradient(
                            colors: [
                              Color(0xFF1A2E42),
                              Color(0xFF0F1E2E),
                            ],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 0.5,
                          ),
                        ),
                        child: Icon(
                          question['imageIcon'],
                          size: 28,
                          color: const Color(0xFF8A9BB0),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        question['title'],
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        question['description'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF8899AA),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 40,
                        height: 1,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        question['question'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFC4D8E8),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: options.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final option = options[index];
                      final bool isSelected = selectedOption == index;
                      final Color optionColor = option['color'] as Color;
                      final bool isDisabled = _isAnswered && !isSelected;

                      return GestureDetector(
                        onTap: _isAnswered ? null : () => _selectOption(index),
                        child: Opacity(
                          opacity: isDisabled ? 0.5 : 1.0,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        optionColor.withOpacity(0.2),
                                        optionColor.withOpacity(0.05),
                                      ],
                                    )
                                  : const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF111E2B),
                                        Color(0xFF0D1620),
                                      ],
                                    ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? optionColor.withOpacity(0.6)
                                    : Colors.white.withOpacity(0.05),
                                width: isSelected ? 1.5 : 0.5,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: optionColor.withOpacity(0.3),
                                        blurRadius: 16,
                                        spreadRadius: -2,
                                      ),
                                    ]
                                  : [
                                      const BoxShadow(
                                        color: Colors.black54,
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 16,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? optionColor
                                            : Colors.white.withOpacity(0.3),
                                        width: 2,
                                      ),
                                    ),
                                    child: isSelected
                                        ? Center(
                                            child: Container(
                                              width: 12,
                                              height: 12,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: optionColor,
                                              ),
                                            ),
                                          )
                                        : null,
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
                                            fontWeight: isSelected
                                                ? FontWeight.w700
                                                : FontWeight.w500,
                                            color: isSelected
                                                ? optionColor
                                                : Colors.white,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          option['description'],
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xFF8899AA),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      size: 20,
                                      color: optionColor,
                                    ),
                                ],
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
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120.0);

    paint.color = const Color(0xFF185FA5).withOpacity(0.15);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.2), 150, paint);

    paint.color = const Color(0xFFD85A30).withOpacity(0.10);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.7), 140, paint);

    paint.color = const Color(0xFF534AB7).withOpacity(0.12);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.9), 120, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}