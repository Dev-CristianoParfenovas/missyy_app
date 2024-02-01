import 'package:flutter/material.dart';
import 'package:missyy/_core/screen_colors.dart';

class QuantityWidget extends StatelessWidget {
  final int value;
  final String suffixText = 'un';
  final Function(int quantity) result;
  final bool isRemovable;

  const QuantityWidget({
    Key? key,
    required this.value,
    suffixText,
    required this.result,
    this.isRemovable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.shade300,
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _QuantityButtom(
              icon: !isRemovable || value > 1
                  ? Icons.remove
                  : Icons.delete_forever,
              color: !isRemovable || value > 1 ? Colors.grey : Colors.red,
              onPressed: () {
                if (value == 1 && !isRemovable) return;
                int resultCount = value - 1;
                result(resultCount);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                '$value$suffixText',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _QuantityButtom(
              icon: Icons.add,
              color: ScreenColors.corPadraoApp,
              onPressed: () {
                int resultCount = value + 1;
                result(resultCount);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityButtom extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButtom({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        child: Ink(
          height: 25,
          width: 30,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
