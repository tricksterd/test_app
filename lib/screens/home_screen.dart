import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/providers/book_provider.dart';
import 'package:test_app/widgets/add_button.dart';
import 'package:test_app/widgets/list_widget.dart';
import 'package:test_app/widgets/loading_widget.dart';
import 'package:test_app/widgets/snackbars.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textFieldController = TextEditingController();
  final textFieldFocusNode = FocusNode();

  @override
  void dispose() {
    textFieldController.dispose();
    textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = context.watch<BookProvider>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Book List'),
          actions: [
            DropdownButton<String>(
              value: bookProvider.choosenSorting,
              elevation: 0,
              underline: const SizedBox(),
              items: <String>[
                'Alphabetical',
                'Index',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  bookProvider.choosenSorting = newValue;
                  bookProvider.sortBooks();
                }
              },
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: bookProvider.isLoading
            ? const LoadingWidget()
            : Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onSubmitted: (String title) {
                                final callback = bookProvider.addBook(title);
                                bottomMessageCallback(callback, context);
                                textFieldController.text = '';
                              },
                              controller: textFieldController,
                              focusNode: textFieldFocusNode,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                label: Text('Add book to collection'),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          AddButton(onTap: () {
                            final callback =
                                bookProvider.addBook(textFieldController.text);
                            bottomMessageCallback(callback, context);
                            textFieldController.text = '';
                            textFieldFocusNode.unfocus();
                          })
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Expanded(child: ListWidget()),
                ],
              ));
  }

  void bottomMessageCallback(bool callback, BuildContext context) {
    if (callback) {
      ScaffoldMessenger.of(context).showSnackBar(
          bottomMessage(title: 'Added book!', color: Colors.green));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          bottomMessage(title: 'Field can\'t be empty', color: Colors.red));
    }
  }
}
