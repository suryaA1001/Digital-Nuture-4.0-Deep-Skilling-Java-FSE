REM   Script: Control Structure-2
REM   Structure-2

CREATE TABLE savings_accounts ( 
    account_id NUMBER PRIMARY KEY, 
    customer_id NUMBER, 
    balance NUMBER 
);

CREATE TABLE employees ( 
    emp_id NUMBER PRIMARY KEY, 
    name VARCHAR2(100), 
    department_id NUMBER, 
    salary NUMBER 
);

CREATE TABLE accounts ( 
    account_id NUMBER PRIMARY KEY, 
    customer_id NUMBER, 
    balance NUMBER 
);

INSERT INTO savings_accounts VALUES (1, 101, 10000);

INSERT INTO savings_accounts VALUES (2, 102, 5000);

INSERT INTO employees VALUES (1, 'Kiran', 10, 40000);

INSERT INTO employees VALUES (2, 'Rohit', 10, 42000);

INSERT INTO employees VALUES (3, 'Neha', 20, 38000);

INSERT INTO accounts VALUES (1, 201, 20000);

INSERT INTO accounts VALUES (2, 201, 10000);

COMMIT;

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS 
BEGIN 
  FOR acc IN (SELECT * FROM savings_accounts) LOOP 
    UPDATE savings_accounts 
    SET balance = balance + (balance * 0.01) 
    WHERE account_id = acc.account_id; 
  END LOOP; 
END; 
/

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus( 
  dept_id IN NUMBER, 
  bonus_percent IN NUMBER 
) AS 
BEGIN 
  UPDATE employees 
  SET salary = salary + (salary * (bonus_percent / 100)) 
  WHERE department_id = dept_id; 
END; 
/

CREATE OR REPLACE PROCEDURE TransferFunds( 
  from_account_id IN NUMBER, 
  to_account_id IN NUMBER, 
  amount IN NUMBER 
) AS 
  from_balance NUMBER; 
BEGIN 
  SELECT balance INTO from_balance 
  FROM accounts WHERE account_id = from_account_id; 
 
  IF from_balance < amount THEN 
    RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance'); 
  ELSE 
    UPDATE accounts 
    SET balance = balance - amount 
    WHERE account_id = from_account_id; 
 
    UPDATE accounts 
    SET balance = balance + amount 
    WHERE account_id = to_account_id; 
  END IF; 
END; 
/

BEGIN 
  ProcessMonthlyInterest; 
END; 
/

BEGIN 
  UpdateEmployeeBonus(10, 10); 
END; 
/

BEGIN 
  TransferFunds(1, 2, 5000); 
END; 
/

SELECT * FROM savings_accounts;

SELECT * FROM employees;

SELECT * FROM accounts;

