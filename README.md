# Magist business questions for Eniac

## Project overview

Eniac sells high-end tech products and has to decide whether to sign a three-year contract with Magist, a Brazilian online marketplace. This project uses SQL to look at two concerns, whether Magist is a good fit for high-end tech and whether it delivers on time.

## Data

The Magist database comes from the WBS Coding School data science course. It contains orders from September 2016 to 17 October 2018, and prices are in euros. The database dump is about 68 MB, so it is not included in this repository.

## Key findings

Tech items are 15.33 percent of the items sold (17,271 of 112,650), while tech products are 11.69 percent of the catalogue. Expensive tech items above 500 euros are only 567 of the tech items sold, about 3.3 percent, which matters because Eniac sells high-end products. There are 493 tech sellers out of 3,095, and they earned about 1.9 million euros, which is 14.00 percent of the 13.6 million earned by all sellers.

Orders are delivered 12.5 days after purchase on average, while Magist promises 24.3 days. Of the delivered orders, 88,649 arrived on time and 7,827 were late, about 8 percent. Deliveries are about three times slower in the remote northern states than in Sao Paulo.

## Files

magist_business_questions_project.sql contains all the queries, each followed by a comment with the answer.

## How to run

Import the magist database in MySQL Workbench first, open the SQL file, and run the queries one by one with Ctrl+Enter.

## Authors

Solange Mekamgoum and Samer Odeh, WBS Coding School, November 2026.
