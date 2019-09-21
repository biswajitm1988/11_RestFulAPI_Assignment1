package com.fsd.spring.repository;

import com.fsd.spring.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookRepository extends JpaRepository<Book, String> {

    @Query("SELECT book FROM Book book WHERE book.id = :bookId")
    Book findByBookId(@Param("bookId") long bookId);

    @Query("DELETE FROM Book book WHERE book.id = :bookId")
    Book deleteByBookId(@Param("bookId") long bookId);
}
