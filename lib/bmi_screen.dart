import 'package:flutter/material.dart';
import 'profile_screen.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? _bmiResult;
  String? _recommendation;
  bool _showError = false;
  bool _showResult = false;
  int _currentIndex = 0;

  void _calculateBMI() {
    if (_heightController.text.isEmpty || _weightController.text.isEmpty) {
      setState(() {
        _showError = true;
        _showResult = false;
      });
      return;
    }

    final height = double.tryParse(_heightController.text) ?? 0;
    final weight = double.tryParse(_weightController.text) ?? 0;

    if (height <= 0 || weight <= 0) {
      setState(() {
        _showError = true;
        _showResult = false;
      });
      return;
    }

    final bmi = weight / ((height / 100) * (height / 100));
    String recommendation;

    if (bmi < 16) {
      recommendation =
          'Выраженный дефицит массы тела. Советуем набрать вес для здоровья.';
    } else if (bmi < 18.5) {
      recommendation =
          'Недостаточная масса тела. Рекомендуется увеличить массу тела.';
    } else if (bmi < 25) {
      recommendation =
          'Норма. Ваш вес в здоровом диапазоне — поддерживайте его!';
    } else if (bmi < 30) {
      recommendation =
          'Избыточная масса тела или предожирение. Желательно снизить вес.';
    } else if (bmi < 35) {
      recommendation =
          'Ожирение. Рекомендуется уменьшить вес под контролем специалиста.';
    } else if (bmi < 40) {
      recommendation =
          'Ожирение резкое. Необходимо снижение веса с медицинской поддержкой.';
    } else {
      recommendation =
          'Очень резкое ожирение. Требуется срочная коррекция веса.';
    }

    setState(() {
      _bmiResult = double.parse(bmi.toStringAsFixed(2));
      _recommendation = recommendation;
      _showError = false;
      _showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Индекс массы тела',
                style: TextStyle(
                  color: Color(0xFF4CAF50),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: cardWidth,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Персональные данные',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Рост (см)'),
                    TextField(
                      controller: _heightController,
                      decoration: const InputDecoration(
                        hintText: '185',
                        border: UnderlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    const Text('Вес (кг)'),
                    TextField(
                      controller: _weightController,
                      decoration: const InputDecoration(
                        hintText: '77',
                        border: UnderlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: cardWidth,
                child: ElevatedButton(
                  onPressed: _calculateBMI,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'РАССЧИТАТЬ',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              if (_showError)
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Заполните все поля',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              if (_showResult) ...[
                const SizedBox(height: 20),
                Container(
                  width: cardWidth,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Ваш индекс массы тела:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _bmiResult.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _recommendation!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Color(0xFF757575)),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              setState(() => _currentIndex = 0);
            },
            child: Text(
              'Калькулятор',
              style: TextStyle(
                color: _currentIndex == 0
                    ? const Color(0xFF4CAF50)
                    : Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() => _currentIndex = 1);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: Text(
              'Профиль',
              style: TextStyle(
                color: _currentIndex == 1
                    ? const Color(0xFF4CAF50)
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
