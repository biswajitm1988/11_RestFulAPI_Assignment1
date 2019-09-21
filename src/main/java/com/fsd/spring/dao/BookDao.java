package com.fsd.spring.dao;

import com.fsd.spring.entity.Book;
import com.fsd.spring.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Component
@Transactional
public class BookDao {

	@Autowired
	private BookRepository bookRepository;

	public void addBook(Book newBook) throws Exception {
		bookRepository.save(newBook);
	}

	public List<Book> getAllBooks() throws Exception {
		return bookRepository.findAll();
	}

	public Optional<Book> searchForBooks(String bookId) throws Exception {
		return Optional.ofNullable(bookRepository.findByBookId(Long.parseLong(bookId)));
	}

	public void deleteBook(String bookId) throws Exception {
		bookRepository.deleteByBookId(Long.parseLong(bookId));
	}

	public void updateBook(Book book) {
		bookRepository.save(book);
	}
}
