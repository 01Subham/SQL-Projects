create database Library;
use library;

create table Authors(
	author_id int primary key,
    first_name varchar (50),
    last_name varchar(50),
    birth_date date,
    nationality varchar(50)
);

create table Books(
	book_id int primary key,
    title varchar(200),
    author_id int,
    publication_year int,
    genre varchar (20),
    pages int,
    available_copies int,
    foreign key (author_id) references authors(author_id) 
);

create table Members(
	member_id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    phone varchar(15),
    join_date date,
    membership_type varchar(20)
);


create table Loans(
	loan_id int primary key,
    book_id int,
    member_id int,
    loan_date date,
    due_date date,
    return_date date,
    fine_amount decimal(5,2),
    foreign key (member_id) references Members(member_id),
    foreign key (book_id) references Books(book_id)
);



-- List all Books of a Specific Genre
select title,genre,publication_year,available_copies
from books 
where genre = 'Science';



-- Find members with Premium membership
select concat(first_name,' ',last_name) as full_name,membership_type 
from members 
where membership_type = 'Premium';




-- Count total number of books
select title as Name_of_Book,Genre,sum(available_copies) as Total_books
from books
group by title,Genre;



-- Books published before 1995
select title,publication_year
from books where publication_year<1995;




--  Books written by a particular author
select b.title,b.genre,b.publication_year
from books b
join authors a on b.author_id = a.author_id
where a.first_name = 'Danielle' and a.last_name = 'Johnson';





-- List all members who joined in the year 2022
select *from members
where year(join_date) = 2022;



-- Total fine collected from all member
select sum(fine_amount) as total_fine 
from loans;



-- Show all members and any loans they have
select concat(m.first_name,' ',m.last_name) as Full_name,l.book_id
from members m
inner join loans l on m.member_id = l.member_id;




-- Get the member who paid the highest fine
select first_name,last_name from members
where member_id = (
	select member_id from loans
    order by fine_amount desc
    limit 1
);



-- View for to show the fine summary per member
CREATE VIEW Member_Fines AS
SELECT 
    m.member_id,
    CONCAT(m.first_name, ' ', m.last_name) AS full_name,
    SUM(l.fine_amount) AS total_fine
FROM members m
JOIN loans l ON m.member_id = l.member_id
GROUP BY m.member_id, m.first_name, m.last_name;

select *from Member_Fines;
