# Consumer Buying Pattern Database

A relational database project built with MySQL to analyze consumer purchasing behavior, product trends, and sales patterns.

---

## Database Structure

**Database Name:** `ConsumerBuyingPattern`

### Tables

| Table | Description |
|-------|-------------|
| `Consumer` | Stores consumer demographic information |
| `Category` | Product category classifications |
| `Product` | Product details including price and category |
| `Purchase` | Transaction records linking consumers and products |

### Entity Relationship Overview

```
Consumer (1) ──< Purchase >── (1) Product
                                      |
                               Category (1)
```

---

## Table Schemas

### Consumer
| Column | Type | Constraints |
|--------|------|-------------|
| Consumer_ID | INT | PRIMARY KEY |
| Name | VARCHAR(50) | NOT NULL |
| Age | INT | |
| Gender | VARCHAR(10) | |
| Location | VARCHAR(50) | |

### Category
| Column | Type | Constraints |
|--------|------|-------------|
| Category_ID | INT | PRIMARY KEY |
| Category_Name | VARCHAR(50) | NOT NULL |

### Product
| Column | Type | Constraints |
|--------|------|-------------|
| Product_ID | INT | PRIMARY KEY |
| Product_Name | VARCHAR(50) | NOT NULL |
| Category_ID | INT | FOREIGN KEY → Category |
| Price | DECIMAL(10,2) | |

### Purchase
| Column | Type | Constraints |
|--------|------|-------------|
| Purchase_ID | INT | PRIMARY KEY |
| Consumer_ID | INT | FOREIGN KEY → Consumer |
| Product_ID | INT | FOREIGN KEY → Product |
| Quantity | INT | |
| Purchase_Date | DATE | |
| Total_Amount | DECIMAL(10,2) | |

---

## Sample Data

- **5 Categories:** Electronics, Clothing, Groceries, Books, Furniture
- **5 Consumers** from Mumbai, Pune, Delhi, Bangalore, Chennai
- **5 Products** ranging from ₹300 to ₹15,000
- **5 Purchase records** dated February 2026

---

## Queries & Features

### Data Retrieval
- Full purchase history with consumer name, product, quantity, amount, and date using multi-table JOINs.

### Analytical Queries

| Query | Description |
|-------|-------------|
| GROUP BY | Total number of purchases per consumer |
| HAVING | Consumers with total spending exceeding ₹5,000 |
| Subquery | Names of consumers who made high-value purchases (> ₹5,000) |
| Most Purchased Product | Product with the highest total quantity sold |
| Category-wise Sales | Total sales revenue grouped by category |
| Monthly Sales Report | Sales totals grouped by month |
| High-Value Customers | Consumers whose cumulative spending exceeds ₹5,000 |

### View
A reusable view `Consumer_Purchase_View` is created for quick access to joined consumer-product-purchase data.

```sql
SELECT * FROM Consumer_Purchase_View;
```

---

## Setup Instructions

1. **Start your MySQL server** and open a MySQL client or workbench.

2. **Run the script** in order:
   ```sql
   -- Step 1: Create and select database
   CREATE DATABASE ConsumerBuyingPattern;
   USE ConsumerBuyingPattern;

   -- Step 2: Create tables (Consumer, Category, Product, Purchase)
   -- Step 3: Insert sample data
   -- Step 4: Run retrieval and analytical queries
   ```

3. **Verify setup:**
   ```sql
   SHOW TABLES;
   SELECT * FROM Consumer_Purchase_View;
   ```

---

## Requirements

- MySQL 5.7+ or MariaDB 10.3+
- No external dependencies

---

## License

This project is intended for academic and educational use.
