import 'package:flutter/material.dart';

class TODOAppBar extends StatelessWidget {
  const TODOAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final EdgeInsets systemInsets = MediaQuery.of(context).padding;
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Container(
          height: systemInsets.top + screenSize.height * 0.15,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                spreadRadius: -5,
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 12.0),
                      child: Text(
                        'Todo List',
                        style: theme.textTheme.headline6?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 12.0),
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'search tasks',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      fillColor: theme.colorScheme.surface,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
