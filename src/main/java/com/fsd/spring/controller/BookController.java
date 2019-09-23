package com.fsd.spring.controller;

import com.fsd.spring.entity.Book;
import com.fsd.spring.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
public class BookController {

    @Autowired
    private BookService bookService;

    @GetMapping({"/","/home"})
    public String home() {
        System.out.println("Book Controller home");
        return "home";
    }

    @GetMapping("/getAllBooks")
    @ResponseBody
    public List<Book>  getAllBooks() throws Exception {
        System.out.println("Book Controller getAllBooks");
        return  bookService.getAllBooks();
    }

    @GetMapping("/getBookById/{bookId}")
    @ResponseBody
    public Book getBookById(@PathVariable(name = "bookId") String bookId) throws Exception {
        System.out.println("Book Controller getBookById >> "+bookId);
        return bookService.searchBookById(bookId);
    }

    @PostMapping("/addBook")
    @ResponseBody
    public List<Book> addBook(@RequestBody Book book) throws Exception {
        System.out.println("Book Controller addBook >> "+book);
        long bookId = bookService.addBook(book);
        return bookService.getAllBooks();
    }

    @PutMapping("/updateBook")
    @ResponseBody
    public Book updateBook(@RequestBody Book book) throws Exception {
        System.out.println("Book Controller updateBook >> "+book);
        bookService.updateBook(book);
        return bookService.searchBookById(String.valueOf(book.getBookId()));
    }

    @DeleteMapping("/deleteBook/{bookId}")
    @ResponseBody
    public List<Book> deleteBook(@PathVariable(name = "bookId") String bookId) throws Exception {
        System.out.println("Book Controller deleteBook >> "+bookId);
        bookService.deleteBook(bookId);
        return bookService.getAllBooks();
    }
}