package com.fsd.spring.service;

import com.fsd.spring.dao.BookDao;
import com.fsd.spring.entity.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
public class BookService {

	@Autowired
	private BookDao bookDao;

	public int deleteBook(String bookId) throws Exception {
		int count = bookDao.getAllBooks().size();
		if (count == 0) {
			System.out.println("There are no books in the system");
			return count;
		}
		bookDao.deleteBook(bookId);
		return count;
	}

	public long addBook(Book newBook) throws Exception {
		bookDao.addBook(newBook);
		System.out.println("\nBook Added. Id=" + newBook.getBookId());
		return newBook.getBookId();
	}
    public Book searchBookById(String bookId) throws Exception {
		int count = bookDao.getAllBooks().size();
		if (count == 0) {
			System.out.println("There are no books in the system");
			return null;
		}
		Book book = bookDao.searchForBooks(bookId);
		if (book==null) {
			System.out.println("no books found for your search : " + bookId);
		} else {
			System.out.println("Matching Books :" + book);
		}
		return book;
    }

	public List<Book> getAllBooks() throws Exception {
		return bookDao.getAllBooks();
	}

	public void updateBook(Book book) throws Exception {
		Book tempbook = bookDao.searchForBooks(String.valueOf(book.getBookId()));
		if (tempbook==null) {
			System.out.println("no books found for your search : " + book.getBookId());
		} else {
			System.out.println("Matching Books :\n" + tempbook);
			bookDao.updateBook(book);
		}
	}
}
