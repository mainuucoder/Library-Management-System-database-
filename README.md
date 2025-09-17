
# 📚 Library Management System Database

This project defines a **relational database schema** for a Library Management System. It manages members, books, authors, publishers, loans, reservations, fines, and user authentication, while supporting operations such as borrowing, reserving, and tracking fines.

---

## 🚀 Features

* **Member Management** – Track library members, membership types, status, fines, and borrowing limits.
* **Book Management** – Store details about books, authors, categories, publishers, and physical copies.
* **Loans & Reservations** – Handle borrowing, returning, overdue fines, and reservation queues.
* **Fine Tracking** – Manage overdue, damaged, or lost book fines with payment status.
* **User Accounts** – Authentication with roles (`member`, `librarian`, `admin`).
* **Inventory** – Track multiple copies of books across branches with condition and availability.
* **Indexes & Constraints** – Optimized queries, enforced rules, and data consistency.

---

## 🗂️ Database Schema Overview

### 1. **Members**

* Stores personal and membership details of library members.
* Tracks borrowing limits, fines, and membership status.

### 2. **Authors**

* Holds author details including biography and nationality.

### 3. **Categories**

* Supports hierarchical categories (e.g., Fiction → Science Fiction).

### 4. **Publishers**

* Stores publisher information such as contact details and website.

### 5. **Books**

* Stores book details (ISBN, title, category, publisher, copies, price, location).
* Linked to authors via a many-to-many relationship.

### 6. **Book Authors**

* Junction table linking books and authors.

### 7. **Loans**

* Tracks book borrowing, due dates, renewals, returns, and fines.

### 8. **Reservations**

* Handles book reservations with priority, notification, and expiry management.

### 9. **Fines**

* Stores fine details for overdue, lost, or damaged books.

### 10. **Users**

* Manages authentication and system roles.
* Each user is linked to a library member.

### 11. **Book Copies**

* Tracks physical book copies across branches with condition and availability.

---

## 🔑 Key Relationships

* **Members ↔ Loans ↔ Books** → Borrowing system
* **Members ↔ Reservations ↔ Books** → Reservation system
* **Books ↔ Authors (Many-to-Many)** → Multiple authors per book
* **Books ↔ Categories** → Genre classification
* **Books ↔ Publishers** → Publishing info
* **Loans ↔ Fines ↔ Members** → Fine tracking
* **Members ↔ Users** → System authentication

---

## 📊 Example Data

Sample inserts are included for:

* Members (students, faculty, public)
* Authors (George Orwell, J.K. Rowling, Stephen King, etc.)
* Categories (Fiction, Non-Fiction, Science Fiction, Technology, etc.)
* Publishers (Penguin Random House, O'Reilly Media, Addison-Wesley, etc.)
* Books with multiple copies and locations
* Active loans, reservations, and fines

---

## ⚙️ Performance & Integrity

* **Indexes**: Added on frequently queried fields (ISBN, member email, category, status).
* **Constraints**:

  * CHECK constraints (borrowing limits, non-negative fines, due date > loan date).
  * UNIQUE constraints (emails, ISBNs, usernames).
  * Foreign keys with cascading updates/deletes where applicable.

---

## 🛠️ Setup Instructions

1. Create the database:

   ```sql
   CREATE DATABASE library_management_db 
   CHARACTER SET utf8mb4 
   COLLATE utf8mb4_unicode_ci;
   ```
2. Switch to the database:

   ```sql
   USE library_management_db;
   ```
3. Run the provided schema SQL script.
4. Verify tables, relationships, and sample data are inserted correctly.

---

## ✅ Future Enhancements

* Branch management for multi-location libraries.
* Advanced reporting (popular books, overdue reports, fine collection reports).
* Stored procedures & triggers for automating fine calculations.
* Integration with a frontend or library management system API.

---

## 📌 License

This schema is provided for **educational and project use by DANIEL MUTAHI**. You are free to modify and extend it for your library system needs.

---



