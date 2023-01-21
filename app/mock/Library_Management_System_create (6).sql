-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-01-19 11:52:06.571

-- tables
-- Table: address
CREATE TABLE library.address (
    id_person int  NOT NULL,
    city varchar(255)  NOT NULL,
    postal_code varchar(255)  NOT NULL,
    street varchar(255)  NOT NULL,
    house_number int  NOT NULL,
    apartment_number int  NULL,
    CONSTRAINT address_pk PRIMARY KEY (id_person)
);

-- Table: author
CREATE TABLE library.author (
    id serial  NOT NULL,
    first_name varchar(255)  NOT NULL,
    last_name varchar(255)  NULL,
    nationality varchar(255)  NULL,
    CONSTRAINT author_pk PRIMARY KEY (id)
);

-- Table: book
CREATE TABLE library.book (
    id serial  NOT NULL,
    isbn varchar(13)  NULL,
    title varchar(255)  NOT NULL,
    language varchar(255)  NOT NULL,
    publication_date date  NOT NULL,
    physical_location varchar(255)  NOT NULL,
    price int  NOT NULL,
    CONSTRAINT id PRIMARY KEY (id)
);

-- Table: book_author
CREATE TABLE library.book_author (
    id_author int  NOT NULL,
    id_book int  NOT NULL,
    CONSTRAINT book_author_pk PRIMARY KEY (id_author,id_book)
);

-- Table: book_genre
CREATE TABLE library.book_genre (
    id_book int  NOT NULL,
    id_genre int  NOT NULL,
    CONSTRAINT book_genre_pk PRIMARY KEY (id_book,id_genre)
);

-- Table: genre
CREATE TABLE library.genre (
    id serial  NOT NULL,
    name varchar(255)  NOT NULL,
    CONSTRAINT genre_pk PRIMARY KEY (id)
);

-- Table: librarian
CREATE TABLE library.librarian (
    id serial  NOT NULL,
    id_person int  NOT NULL,
    id_supervisor int  NULL,
    salary int  NOT NULL,
    job_position varchar(255)  NOT NULL,
    CONSTRAINT librarian_pk PRIMARY KEY (id)
);

-- Table: loan
CREATE TABLE library.loan (
    id bigserial  NOT NULL,
    id_book int  NOT NULL,
    id_member int  NOT NULL,
    id_librarian int  NOT NULL,
    loan_date date  NOT NULL,
    return_date date  NULL,
    due_date date  NOT NULL,
    CONSTRAINT loan_pk PRIMARY KEY (id)
);

-- Table: member
CREATE TABLE library.member (
    id serial  NOT NULL,
    id_person int  NOT NULL,
    join_date date  NOT NULL,
    expiration_date date  NOT NULL,
    CONSTRAINT member_pk PRIMARY KEY (id)
);

-- Table: payment
CREATE TABLE library.payment (
    id serial  NOT NULL,
    id_member int  NOT NULL,
    id_librarian int  NOT NULL,
    type varchar(255)  NOT NULL,
    issue_date date  NOT NULL,
    to_pay int  NOT NULL,
    is_paid boolean  NOT NULL DEFAULT false,
    CONSTRAINT payment_pk PRIMARY KEY (id)
);

-- Table: person
CREATE TABLE library.person (
    id serial  NOT NULL,
    first_name varchar(255)  NOT NULL,
    last_name varchar(255)  NOT NULL,
    pesel bigint  NOT NULL CHECK (pesel > 9999999999 and pesel < 100000000000 ),
    birth_date date  NOT NULL,
    email varchar(255)  NOT NULL,
    CONSTRAINT pesel UNIQUE (pesel) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT person_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: address__person (table: address)
ALTER TABLE library.address ADD CONSTRAINT address__person
    FOREIGN KEY (id_person)
    REFERENCES library.person (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: book_author__author (table: book_author)
ALTER TABLE library.book_author ADD CONSTRAINT book_author__author
    FOREIGN KEY (id_author)
    REFERENCES library.author (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: book_author__book (table: book_author)
ALTER TABLE library.book_author ADD CONSTRAINT book_author__book
    FOREIGN KEY (id_book)
    REFERENCES library.book (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: book_genre__book (table: book_genre)
ALTER TABLE library.book_genre ADD CONSTRAINT book_genre__book
    FOREIGN KEY (id_book)
    REFERENCES library.book (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: book_genre__genre (table: book_genre)
ALTER TABLE library.book_genre ADD CONSTRAINT book_genre__genre
    FOREIGN KEY (id_genre)
    REFERENCES library.genre (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: librarian__librarian (table: librarian)
ALTER TABLE library.librarian ADD CONSTRAINT librarian__librarian
    FOREIGN KEY (id_supervisor)
    REFERENCES library.librarian (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: librarian__person (table: librarian)
ALTER TABLE library.librarian ADD CONSTRAINT librarian__person
    FOREIGN KEY (id_person)
    REFERENCES library.person (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: loan__book (table: loan)
ALTER TABLE library.loan ADD CONSTRAINT loan__book
    FOREIGN KEY (id_book)
    REFERENCES library.book (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: loan__librarian (table: loan)
ALTER TABLE library.loan ADD CONSTRAINT loan__librarian
    FOREIGN KEY (id_librarian)
    REFERENCES library.librarian (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: loan__member (table: loan)
ALTER TABLE library.loan ADD CONSTRAINT loan__member
    FOREIGN KEY (id_member)
    REFERENCES library.member (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: member__person (table: member)
ALTER TABLE library.member ADD CONSTRAINT member__person
    FOREIGN KEY (id_person)
    REFERENCES library.person (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: payment__librarian (table: payment)
ALTER TABLE library.payment ADD CONSTRAINT payment__librarian
    FOREIGN KEY (id_librarian)
    REFERENCES library.librarian (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: payment__member (table: payment)
ALTER TABLE library.payment ADD CONSTRAINT payment__member
    FOREIGN KEY (id_member)
    REFERENCES library.member (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.
