import 'package:flutter/material.dart';
import 'book.dart';
import 'book_detail_page.dart';
import 'add_book_page.dart';


class HomePage extends StatelessWidget {
  final List<Book> books = [
    Book(
      title: 'Harry potter and the Deathly Hallows',
      pageCount: 200,
      imageUrl: 'https://cdn.kobo.com/book-images/9d863d07-4a3f-4ccf-95bb-faf1660d25df/1200/1200/False/harry-potter-and-the-deathly-hallows-4.jpg',
    ),
    Book(
      title: 'Harry Potter and the Philosopher\'s Stone',
      pageCount: 150,
      imageUrl: 'https://cdn.kobo.com/book-images/6750d058-29cb-4626-9c12-a62e816a80cc/1200/1200/False/harry-potter-and-the-philosopher-s-stone-3.jpg',
    ),
    Book(
      title: 'Harry potter and the Deathly Hallows',
      pageCount: 200,
      imageUrl: 'https://cdn.kobo.com/book-images/9d863d07-4a3f-4ccf-95bb-faf1660d25df/1200/1200/False/harry-potter-and-the-deathly-hallows-4.jpg',
    ),
    Book(
      title: 'Harry Potter and the Philosopher\'s Stone',
      pageCount: 150,
      imageUrl: 'https://cdn.kobo.com/book-images/6750d058-29cb-4626-9c12-a62e816a80cc/1200/1200/False/harry-potter-and-the-philosopher-s-stone-3.jpg',
    ),
    Book(
      title: 'Harry potter and the Deathly Hallows',
      pageCount: 200,
      imageUrl: 'https://cdn.kobo.com/book-images/9d863d07-4a3f-4ccf-95bb-faf1660d25df/1200/1200/False/harry-potter-and-the-deathly-hallows-4.jpg',
    ),
    Book(
      title: 'Harry Potter and the Philosopher\'s Stone',
      pageCount: 150,
      imageUrl: 'https://cdn.kobo.com/book-images/6750d058-29cb-4626-9c12-a62e816a80cc/1200/1200/False/harry-potter-and-the-philosopher-s-stone-3.jpg',
    ),
    Book(
      title: 'Harry potter and the Deathly Hallows',
      pageCount: 200,
      imageUrl: 'https://cdn.kobo.com/book-images/9d863d07-4a3f-4ccf-95bb-faf1660d25df/1200/1200/False/harry-potter-and-the-deathly-hallows-4.jpg',
    ),
    Book(
      title: 'Harry Potter and the Philosopher\'s Stone',
      pageCount: 150,
      imageUrl: 'https://cdn.kobo.com/book-images/6750d058-29cb-4626-9c12-a62e816a80cc/1200/1200/False/harry-potter-and-the-philosopher-s-stone-3.jpg',
    ),
    Book(
      title: 'Harry potter and the Deathly Hallows',
      pageCount: 200,
      imageUrl: 'https://cdn.kobo.com/book-images/9d863d07-4a3f-4ccf-95bb-faf1660d25df/1200/1200/False/harry-potter-and-the-deathly-hallows-4.jpg',
    ),

    // Book(
    //   title: 'Book 2',
    //   pageCount: 150,
    //   imageUrl: 'book2.jpg',
    // ),
    // Book(
    //   title: 'Book 2',
    //   pageCount: 150,
    //   imageUrl: 'book2.jpg',
    // ),

    // Add more books...
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top:50, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Hi Robbert',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'Book Library',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailPage(book: books[index]),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(books[index].imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    books[index].title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${books[index].pageCount} pages',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
