import 'dart:developer';

import 'package:flutter/material.dart';

class Customstepper extends StatefulWidget {
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
  State<Customstepper> createState() => _CustomstepperState();
}

class _CustomstepperState extends State<Customstepper> {
  late List<GlobalKey> _stepKey;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _stepKey = List.generate(widget.steps.length, ((_) => GlobalKey()));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Customstepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToStep(widget.currentStep);
      });
    }
  }

  void _scrollToStep(int index) {
    if (index < 0 || index >= _stepKey.length) return;

    final context = _stepKey[index].currentContext;
    if (context != null) {
      log("on update Widget");
      Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.5);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Row(
        children: List.generate(widget.steps.length, (index) {
          final isActive = index == widget.currentStep;
          final isCompleted = index < widget.currentStep;

          return Container(
            key: _stepKey[index],
            child: Row(
              children: [
                // STEP CIRCLE
                GestureDetector(
                  onTap: isCompleted
                      ? () {
                          log("here");
                          widget.onStepTapped(index);
                        }
                      : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Colors.teal.shade300
                          : (isActive
                              ? Colors.yellow.shade300
                              : Colors.grey.shade400),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: isCompleted
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 18)
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
                  widget.steps[index],
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive
                        ? Colors.yellow.shade200
                        : Colors.grey.shade200,
                  ),
                ),

                // LINE
                if (index != widget.steps.length - 1)
                  SizedBox(
                      width: 30,
                      child: Icon(
                        Icons.chevron_right,
                        color: isCompleted
                            ? Theme.of(context).primaryColorLight
                            : Colors.grey.shade400,
                      )),
              ],
            ),
          );
        }),
      ),
    );
  }
}
