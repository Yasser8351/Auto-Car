import 'package:flutter/material.dart';

class AnimatedTextWIthCard extends StatelessWidget {
  const AnimatedTextWIthCard({
    Key? key,
    required this.title,
    required this.discreption,
    required this.expand,
    required this.onTap,
  }) : super(key: key);
  final title;
  final discreption;
  final bool expand;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            trailing: Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(
                expand ? Icons.expand_less : Icons.expand_more,
                color: expand
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: onTap,
            ),
          ),
        ),
        const SizedBox(height: 10),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: expand
                  ? const SizedBox()
                  : Text(
                      discreption,
                      style: TextStyle(
                          color: Color.fromARGB(255, 139, 139, 145),
                          fontSize: 17),
                      //style: AppConfig.textSpecifications,
                      textAlign: TextAlign.end,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
