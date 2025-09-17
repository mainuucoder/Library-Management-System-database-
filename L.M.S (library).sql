-- Library Management System Database Schema
CREATE DATABASE library_management_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE library_management_db;

-- Members table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    library_id VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE NOT NULL,
    membership_type ENUM('student', 'faculty', 'public') NOT NULL,
    membership_status ENUM('active', 'suspended', 'expired') DEFAULT 'active',
    join_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    max_books_allowed INT DEFAULT 5 CHECK (max_books_allowed BETWEEN 1 AND 10),
    total_fines DECIMAL(8,2) DEFAULT 0.00 CHECK (total_fines >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- Insert members
INSERT INTO members (library_id, first_name, last_name, email, phone, date_of_birth, membership_type, membership_status, join_date, expiry_date, max_books_allowed, total_fines) VALUES
('LIB1001', 'John', 'Smith', 'john.smith@email.com', '555-0101', '1990-05-15', 'student', 'active', '2024-01-15', '2025-01-15', 5, 0.00),
('LIB1002', 'Sarah', 'Johnson', 'sarah.j@email.com', '555-0102', '1985-08-22', 'faculty', 'active', '2023-11-20', '2025-11-20', 10, 0.00),
('LIB1003', 'Mike', 'Wilson', 'mike.wilson@email.com', '555-0103', '1978-12-03', 'public', 'active', '2024-03-10', '2025-03-10', 3, 2.50),
('LIB1004', 'Emily', 'Davis', 'emily.d@email.com', '555-0104', '1995-02-28', 'student', 'active', '2024-02-01', '2025-02-01', 5, 0.00),
('LIB1005', 'David', 'Brown', 'david.brown@email.com', '555-0105', '1982-07-19', 'faculty', 'suspended', '2023-09-15', '2025-09-15', 10, 15.75);

-- Authors table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_year YEAR,
    death_year YEAR,
    nationality VARCHAR(50),
    biography TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Insert authors
INSERT INTO authors (first_name, last_name, birth_year, death_year, nationality, biography) VALUES
('George', 'Orwell', 1903, 1950, 'British', 'English novelist, essayist, journalist and critic known for his dystopian novel 1984.'),
('J.K.', 'Rowling', 1965, NULL, 'British', 'British author best known for the Harry Potter fantasy series.'),
('Stephen', 'King', 1947, NULL, 'American', 'American author of horror, supernatural fiction, suspense, and fantasy novels.'),
('Michelle', 'Obama', 1964, NULL, 'American', 'American lawyer, university administrator, and writer who served as first lady of the United States.'),
('Martin', 'Kleppmann', 1979, NULL, 'British', 'Researcher and author working on distributed systems and data infrastructure.'),
('Robert', 'Martin', 1952, NULL, 'American', 'American software engineer and author, advocate for Agile development methods.');
-- Categories table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    parent_category_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);
-- Insert categories
INSERT INTO categories (name, description, parent_category_id) VALUES
('Fiction', 'Imaginative literature and storytelling', NULL),
('Non-Fiction', 'Factual literature based on real events', NULL),
('Science Fiction', 'Futuristic and scientific themes', 1),
('Mystery', 'Crime and detective stories', 1),
('Biography', 'Accounts of people''s lives', 2),
('Technology', 'Books about computers and technology', 2),
('Fantasy', 'Magical and supernatural elements', 1),
('Romance', 'Love stories and relationships', 1);


-- Publishers table
CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    address TEXT,
    phone VARCHAR(20),
    email VARCHAR(100),
    website VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Insert publishers
INSERT INTO publishers (name, address, phone, email, website) VALUES
('Penguin Random House', '1745 Broadway, New York, NY 10019', '+1-212-782-9000', 'info@penguinrandomhouse.com', 'https://www.penguinrandomhouse.com'),
('HarperCollins', '195 Broadway, New York, NY 10007', '+1-212-207-7000', 'contact@harpercollins.com', 'https://www.harpercollins.com'),
('Macmillan Publishers', '120 Broadway, New York, NY 10271', '+1-646-307-5151', 'info@macmillan.com', 'https://www.macmillan.com'),
('O''Reilly Media', '1005 Gravenstein Highway North, Sebastopol, CA 95472', '+1-707-827-7000', 'orders@oreilly.com', 'https://www.oreilly.com'),
('Addison-Wesley', '75 Arlington Street, Boston, MA 02116', '+1-800-382-3419', 'aw@aw.com', 'https://www.aw.com');
-- Books table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    edition VARCHAR(50),
    publication_year YEAR,
    publisher_id INT NOT NULL,
    category_id INT NOT NULL,
    page_count INT CHECK (page_count > 0),
    language VARCHAR(50) DEFAULT 'English',
    description TEXT,
    price DECIMAL(8,2) CHECK (price >= 0),
    total_copies INT NOT NULL DEFAULT 1 CHECK (total_copies >= 0),
    available_copies INT NOT NULL DEFAULT 1 CHECK (available_copies >= 0),
    location VARCHAR(100),
    status ENUM('available', 'maintenance', 'lost') DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Insert books
INSERT INTO books (isbn, title, edition, publication_year, publisher_id, category_id, page_count, language, description, price, total_copies, available_copies, location, status) VALUES
('978-0451524935', '1984', '1st', 1949, 1, 3, 328, 'English', 'A dystopian social science fiction novel and cautionary tale.', 9.99, 5, 4, 'Fiction Aisle, Shelf 3', 'available'),
('978-0439064873', 'Harry Potter and the Chamber of Secrets', '1st', 1998, 2, 7, 341, 'English', 'The second novel in the Harry Potter series.', 12.99, 3, 2, 'Fantasy Section, Shelf 1', 'available'),
('978-1501142970', 'It', 'Reprint', 1986, 3, 4, 1138, 'English', 'A horror novel about seven children terrorized by an evil entity.', 18.99, 2, 1, 'Horror Section, Shelf 2', 'available'),
('978-1524763138', 'Becoming', '1st', 2018, 1, 5, 448, 'English', 'Memoir by former First Lady of the United States Michelle Obama.', 22.99, 4, 3, 'Biography Aisle, Shelf 4', 'available'),
('978-1449373320', 'Designing Data-Intensive Applications', '1st', 2017, 4, 6, 600, 'English', 'The big ideas behind reliable, scalable, and maintainable systems.', 49.99, 2, 1, 'Technology Section, Shelf 5', 'available'),
('978-0134494166', 'Clean Architecture', '1st', 2017, 5, 6, 432, 'English', 'A craftsman''s guide to software structure and design.', 34.99, 3, 2, 'Technology Section, Shelf 6', 'available'),
('978-0132350884', 'Clean Code', '1st', 2008, 5, 6, 464, 'English', 'A handbook of agile software craftsmanship.', 37.99, 4, 3, 'Technology Section, Shelf 7', 'available'),
('978-0439136365', 'Harry Potter and the Prisoner of Azkaban', '1st', 1999, 2, 7, 435, 'English', 'The third novel in the Harry Potter series.', 13.99, 3, 2, 'Fantasy Section, Shelf 1', 'available');


-- Book-Authors junction table (Many-to-Many relationship)
CREATE TABLE book_authors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

-- Link books to authors (Many-to-Many relationship)
INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1), -- 1984 by George Orwell
(2, 2), -- Harry Potter by J.K. Rowling
(3, 3), -- It by Stephen King
(4, 4), -- Becoming by Michelle Obama
(5, 5), -- Designing Data-Intensive Applications by Martin Kleppmann
(6, 6), -- Clean Architecture by Robert Martin
(7, 6), -- Clean Code by Robert Martin
(8, 2); -- Harry Potter by J.K. Rowling

-- Loans table
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    renewal_count INT DEFAULT 0 CHECK (renewal_count BETWEEN 0 AND 2),
    fine_amount DECIMAL(8,2) DEFAULT 0.00 CHECK (fine_amount >= 0),
    status ENUM('active', 'returned', 'overdue') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    CHECK (due_date > loan_date),
    CHECK (return_date IS NULL OR return_date >= loan_date)
);
-- Insert loans
INSERT INTO loans (member_id, book_id, loan_date, due_date, return_date, renewal_count, fine_amount, status) VALUES
(1, 1, '2024-06-01', '2024-06-15', NULL, 0, 0.00, 'active'),
(2, 5, '2024-05-28', '2024-06-11', NULL, 1, 0.00, 'active'),
(3, 3, '2024-05-20', '2024-06-03', '2024-06-05', 0, 1.00, 'returned'),
(4, 2, '2024-06-03', '2024-06-17', NULL, 0, 0.00, 'active'),
(2, 6, '2024-05-25', '2024-06-08', NULL, 0, 0.00, 'active');

-- Reservations table
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'ready', 'cancelled', 'fulfilled') DEFAULT 'pending',
    priority INT DEFAULT 0,
    notification_sent BOOLEAN DEFAULT FALSE,
    expiry_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    UNIQUE KEY unique_active_reservation (member_id, book_id, status)
);
-- Insert reservations
INSERT INTO reservations (member_id, book_id, reservation_date, status, priority, notification_sent, expiry_date) VALUES
(3, 1, '2024-06-05 10:30:00', 'pending', 1, FALSE, '2024-06-12'),
(4, 5, '2024-06-02 14:15:00', 'ready', 2, TRUE, '2024-06-09'),
(1, 3, '2024-06-04 09:00:00', 'pending', 1, FALSE, '2024-06-11');

-- Fines table
CREATE TABLE fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    loan_id INT NOT NULL,
    amount DECIMAL(8,2) NOT NULL CHECK (amount > 0),
    reason ENUM('overdue', 'damage', 'lost') NOT NULL,
    issued_date DATE NOT NULL,
    paid_date DATE NULL,
    status ENUM('unpaid', 'paid', 'waived') DEFAULT 'unpaid',
    description TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);
-- Insert fines
INSERT INTO fines (member_id, loan_id, amount, reason, issued_date, paid_date, status, description) VALUES
(3, 3, 1.00, 'overdue', '2024-06-04', NULL, 'unpaid', 'Book returned 2 days late'),
(5, 5, 15.75, 'lost', '2024-05-20', NULL, 'unpaid', 'Lost book replacement fee');


-- User authentication and roles
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('member', 'librarian', 'admin') DEFAULT 'member',
    last_login TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);
-- Book copies inventory (for multiple copies of same book)
CREATE TABLE book_copies (
    copy_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    branch_id INT NOT NULL,
    barcode VARCHAR(50) UNIQUE NOT NULL,
    acquisition_date DATE,
    conditions ENUM('new', 'good', 'fair', 'poor', 'withdrawn') DEFAULT 'good',
    status ENUM('available', 'checked_out', 'reserved', 'maintenance', 'lost') DEFAULT 'available',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    INDEX idx_barcode (barcode)
);
-- Update available copies based on current loans
-- using temporary table
CREATE TEMPORARY TABLE temp_book_updates AS
SELECT 
    b.book_id,
    b.total_copies - COUNT(l.loan_id) as new_available_copies
FROM books b
LEFT JOIN loans l ON b.book_id = l.book_id AND l.status = 'active'
GROUP BY b.book_id, b.total_copies;

UPDATE books b
JOIN temp_book_updates t ON b.book_id = t.book_id
SET b.available_copies = t.new_available_copies;

DROP TEMPORARY TABLE temp_book_updates;
-- Create indexes for better performance
CREATE INDEX idx_members_email ON members(email);
CREATE INDEX idx_members_library_id ON members(library_id);
CREATE INDEX idx_members_name ON members(last_name, first_name);
CREATE INDEX idx_members_membership ON members(membership_type, membership_status);

CREATE INDEX idx_authors_name ON authors(last_name, first_name);

CREATE INDEX idx_categories_name ON categories(name);

CREATE INDEX idx_publishers_name ON publishers(name);

CREATE INDEX idx_books_isbn ON books(isbn);
CREATE INDEX idx_books_title ON books(title);
CREATE INDEX idx_books_category ON books(category_id);
CREATE INDEX idx_books_status ON books(status);
CREATE INDEX idx_books_availability ON books(available_copies);

CREATE INDEX idx_book_authors_author ON book_authors(author_id);

CREATE INDEX idx_loans_member ON loans(member_id, status);
CREATE INDEX idx_loans_book ON loans(book_id);
CREATE INDEX idx_loans_due_date ON loans(due_date);
CREATE INDEX idx_loans_status ON loans(status);

CREATE INDEX idx_reservations_member ON reservations(member_id);
CREATE INDEX idx_reservations_book ON reservations(book_id);
CREATE INDEX idx_reservations_status ON reservations(status);
CREATE INDEX idx_reservations_priority ON reservations(priority);

CREATE INDEX idx_fines_member ON fines(member_id, status);
CREATE INDEX idx_fines_status ON fines(status);
CREATE INDEX idx_fines_issue_date ON fines(issued_date);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_book_copies_status ON book_copies(status);



















