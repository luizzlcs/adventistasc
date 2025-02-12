import 'package:adventistasc/app/pages/counter_controller.dart';
import 'package:flutter/material.dart';

class StatisticOfThePage extends StatelessWidget {
  const StatisticOfThePage({super.key, required this.controller});

  final CounterController controller;
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Igreja Adventista do 7º Dia - Conj. Sat. Catarina, Natal - RN',
          style: TextStyle(
            color: Color.fromARGB(255, 189, 188, 188),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return controller.isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                        child: LinearProgressIndicator(),
                      )
                    : Text(
                        'Número de acessos: ${controller.pageAccessCount}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 122, 122, 122)),
                      );
              }),
        ),
      ],
    );
  }
}
