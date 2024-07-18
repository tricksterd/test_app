import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/providers/book_provider.dart';
import 'package:test_app/widgets/snackbars.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bookProvider = context.watch<BookProvider>();
    return ListView.builder(
        itemCount: bookProvider.books.length,
        itemBuilder: ((BuildContext context, int index) {
          final book = bookProvider.books[index];
          return ListTile(
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Confirm'),
                          content: const Text(
                              'Are you sure you want to delete this item?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: () {
                                  bookProvider.removeBook(book);

                                  Navigator.of(context).pop();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      bottomMessage(
                                          title: 'Book removed',
                                          color: Colors.green));
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        ));
              },
            ),
            title: Text(book.title),
          );
        }));
  }
}
