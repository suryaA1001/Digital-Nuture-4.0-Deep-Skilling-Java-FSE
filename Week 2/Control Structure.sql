REM   Script: Control Structure
REM   Control Structure

SET SERVEROUTPUT ON


CREATE TABLE customers ( 
    customer_id NUMBER PRIMARY KEY, 
    name VARCHAR2(100), 
    age NUMBER, 
    balance NUMBER, 
    isVIP CHAR(1) DEFAULT 'N' 
);

CREATE TABLE loans ( 
    loan_id NUMBER PRIMARY KEY, 
    customer_id NUMBER, 
    interest_rate NUMBER, 
    due_date DATE, 
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);

INSERT INTO customers VALUES (1, 'Rohan', 65, 12000, 'N');

INSERT INTO customers VALUES (2, 'Sneha', 58, 8000, 'N');

INSERT INTO customers VALUES (3, 'Meera', 70, 15000, 'N');

INSERT INTO loans VALUES (101, 1, 7.5, SYSDATE + 10);

INSERT INTO loans VALUES (102, 2, 8.0, SYSDATE + 40);

INSERT INTO loans VALUES (103, 3, 6.5, SYSDATE + 5);

BEGIN 
  FOR cust IN (SELECT c.customer_id, l.loan_id, l.interest_rate 
               FROM customers c 
               JOIN loans l ON c.customer_id = l.customer_id 
               WHERE c.age > 60) LOOP 
    UPDATE loans 
    SET interest_rate = interest_rate - 1 
    WHERE loan_id = cust.loan_id; 
  END LOOP; 
END; 
/

BEGIN 
  FOR cust IN (SELECT customer_id FROM customers WHERE balance > 10000) LOOP 
    UPDATE customers 
    SET isVIP = 'Y' 
    WHERE customer_id = cust.customer_id; 
  END LOOP; 
END; 
/

BEGIN 
  FOR loan_rec IN ( 
    SELECT l.loan_id, c.name, l.due_date 
    FROM loans l 
    JOIN customers c ON l.customer_id = c.customer_id 
    WHERE l.due_date <= SYSDATE + 30 
  ) LOOP 
    DBMS_OUTPUT.PUT_LINE('Reminder: ' || loan_rec.name || 
                         ' has a loan (ID: ' || loan_rec.loan_id || 
                         ') due on ' || TO_CHAR(loan_rec.due_date, 'DD-MON-YYYY')); 
  END LOOP; 
END; 
/

SELECT * FROM loans;

SELECT * FROM customers;

SET SERVEROUTPUT ON


CREATE TABLE customers ( 
    customer_id NUMBER PRIMARY KEY, 
    name VARCHAR2(100), 
    age NUMBER, 
    balance NUMBER, 
    isVIP CHAR(1) DEFAULT 'N' 
);

CREATE TABLE loans ( 
    loan_id NUMBER PRIMARY KEY, 
    customer_id NUMBER, 
    interest_rate NUMBER, 
    due_date DATE, 
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);

INSERT INTO customers VALUES (1, 'Rohan', 65, 12000, 'N');

INSERT INTO customers VALUES (2, 'Sneha', 58, 8000, 'N');

INSERT INTO customers VALUES (3, 'Meera', 70, 15000, 'N');

INSERT INTO loans VALUES (101, 1, 7.5, SYSDATE + 10);

INSERT INTO loans VALUES (102, 2, 8.0, SYSDATE + 40);

INSERT INTO loans VALUES (103, 3, 6.5, SYSDATE + 5);

BEGIN 
  FOR cust IN (SELECT c.customer_id, l.loan_id, l.interest_rate 
               FROM customers c 
               JOIN loans l ON c.customer_id = l.customer_id 
               WHERE c.age > 60) LOOP 
    UPDATE loans 
    SET interest_rate = interest_rate - 1 
    WHERE loan_id = cust.loan_id; 
  END LOOP; 
END; 
/

BEGIN 
  FOR cust IN (SELECT customer_id FROM customers WHERE balance > 10000) LOOP 
    UPDATE customers 
    SET isVIP = 'Y' 
    WHERE customer_id = cust.customer_id; 
  END LOOP; 
END; 
/

BEGIN 
  FOR loan_rec IN ( 
    SELECT l.loan_id, c.name, l.due_date 
    FROM loans l 
    JOIN customers c ON l.customer_id = c.customer_id 
    WHERE l.due_date <= SYSDATE + 30 
  ) LOOP 
    DBMS_OUTPUT.PUT_LINE('Reminder: ' || loan_rec.name || 
                         ' has a loan (ID: ' || loan_rec.loan_id || 
                         ') due on ' || TO_CHAR(loan_rec.due_date, 'DD-MON-YYYY')); 
  END LOOP; 
END; 
/

SELECT * FROM loans;

SELECT * FROM customers;

