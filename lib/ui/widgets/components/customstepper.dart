import 'package:flutter/material.dart';

class Customstepper extends StatelessWidget {
  final int currentStep;
  final List<String> steps;
  final Function(int) onStepTapped;

  const Customstepper({
    super.key,
    required this.currentStep,
    required this.steps,
    required this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(steps.length, (index) {
          final isActive = index == currentStep;
          final isCompleted = index < currentStep;

          return Row(
            children: [
              // STEP CIRCLE
              GestureDetector(
                onTap: isCompleted ? () => onStepTapped(index) : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCompleted || isActive
                        ? Colors.yellowAccent.shade200
                        : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, color: Colors.teal, size: 18)
                        : Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: isActive ? Colors.indigo : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // STEP LABEL
              Text(
                steps[index],
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? Colors.yellowAccent : Colors.grey,
                ),
              ),

              // LINE
              if (index != steps.length - 1)
                SizedBox(
                    width: 30,
                    child: Icon(
                      Icons.chevron_right,
                      color: isCompleted ? Colors.blue : Colors.grey.shade400,
                    )),
            ],
          );
        }),
      ),
    );
  }
}
