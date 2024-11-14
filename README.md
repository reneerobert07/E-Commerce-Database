# E-Commerce-Relational-Database
This project implements a relational database model for an e-commerce platform, designed to track customer orders, product inventory, returns, and reviews. This project was designed to enhance and deepen MySQL expertise by building a relational database system for an e-commerce platform. It focuses on the full lifecycle of data management, from designing the database schema to generating and querying data, all while leveraging advanced MySQL techniques to ensure efficiency, integrity, and scalability. Through this project, I gained hands-on experience with various aspects of MySQL that are critical in the development of real-world database systems. 
## Table of Contents:
1. Project Overview
2. Installation
3. Usage
4. Features
5. Technologies Used
6. Database Schema
7. Query Examples
8. Triggers
9. Contributions
10. License
11. Contact
## Project Overview
This project followed a structured approach to building an e-commerce relational database, where each step focused on ensuring the integrity and efficiency of the database:
1. Entity-Relationship (ER) Model: The project began with designing the ER model, outlining the key entities (e.g., Customer, Product, Order, etc.) and their relationships. I used both crow-foot notation and min-max cardinality notation to define how the entities interact, ensuring clear, logical data relationships.
2. Relational Model: I then translated the ER model into a relational model, defining the tables and relationships. Special attention was given to ensuring proper foreign keys, handling null values, and addressing other constraints to maintain data integrity and consistency.
3. Database Creation in DBBrowser: Using DBBrowser, I created the actual database, setting up the tables and implementing relationships based on the relational model. This step ensured that all foreign key dependencies and business rules were correctly applied.
4. Data Generation with Python: I used Python, along with the Faker library, to generate realistic, synthetic data for testing. This included customer profiles, orders, products, reviews, and more, ensuring that the database was populated with meaningful and accurate data to simulate real-world use cases.
5. Advanced SQL Queries for Data Analysis: After populating the database, I applied advanced SQL queries to answer real-world business questions. This involved using techniques such as Common Table Expressions (CTEs), aggregations, and joins to analyze sales trends, identify top-selling products, and calculate month-over-month growth—tasks typical in e-commerce analytics.

This structured approach allowed me to not only build a functional and efficient database but also to explore real-world applications of data analysis using MySQL.
## Installation 
To get started with the project locally, follow the instructions below:
### Prequisites
-  MySQL installed.
-   Python for generating sample data.
### Steps:
1. Clone the repository
2. Set up the database by running the provided SQL script.
3. Generata data using the Python script.

## Usage
Once the database is set up and data is generated, you can query the database to retrieve useful insights about the e-commerce system.

## Technologies Used
1. Database : MySQL
2. Programming Languages: SQL, Python
3. Libraries: Faker, Pandas
4. Tools: DBBrowser, JupyterNotebook

## Database Schema
The database is linked in the file under 'ER Model'. 

## Triggers
One of the core features of this database is the implementation of triggers to maintain data integrity. The example is linked in the file under 'Triggers'.

## Contributing 
Feel free to fork this repository, make changes, and submit pull requests. Contributions are welcome, especially to improve the data generation process or to add more complex queries and views.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Contact
For any questions and queries, feel free to reach out :
- Email: reneerobert.0703@gmail.com
- LinkedIn: Renee Priya Robert 



