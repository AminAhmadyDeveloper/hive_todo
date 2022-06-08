import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo/config/system_bars.dart';
import 'package:hive_todo/config/themes/main_theme.dart';
import 'package:hive_todo/models/todo.dart';

import 'widgets/todo_appbar.dart';

Future<void> main(List<String> args) async {
  await Hive.initFlutter();
  Hive.registerAdapter(TODOAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<TODO>('TODO');
  runApp(const HiveTODO());
}

class HiveTODO extends StatelessWidget {
  const HiveTODO({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MainTheme().set(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final Box<TODO> todoBox = Hive.box('TODO');
    final ThemeData theme = Theme.of(context);
    SystemBars.set();

    return ValueListenableBuilder<Box<TODO>>(
        valueListenable: todoBox.listenable(),
        builder: (context, todoBox, _) {
          return Scaffold(
            body: Column(
              children: [
                const TODOAppBar(),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Today',
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            height: 3,
                            width: 60,
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            todoBox.clear();
                          },
                          child: Row(
                            children: [
                              Text(
                                'Delete All',
                                style: TextStyle(
                                  color: theme.colorScheme.onTertiary,
                                ),
                              ),
                              Icon(
                                Icons.clear,
                                color: theme.colorScheme.onTertiary,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    itemCount: todoBox.values.length,
                    itemBuilder: ((context, index) {
                      final TODO todo = todoBox.values.elementAt(index);
                      return Text(
                        todo.name,
                        style: const TextStyle(fontSize: 24),
                      );
                    }),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTODOScreen(),
                  ),
                );
              },
              label: Row(
                children: const [
                  Text('Add TODO'),
                  SizedBox(width: 8),
                  Icon(Icons.add),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        });
  }
}

class EditTODOScreen extends StatelessWidget {
  EditTODOScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Box<TODO> todoBox = Hive.box('TODO');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit TODO'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                label: Text('Add a todo for today'),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final TODO todo = TODO();
          todo.name = _controller.text;
          todo.isDone = false;
          todo.priority = Priority.low;
          if (todo.isInBox) {
            todo.save();
          } else {
            todoBox.add(todo);
          }
          Navigator.pop(context);
        },
        label: Row(
          children: const [
            Text('Save TODO'),
            SizedBox(width: 8),
            Icon(Icons.check),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
