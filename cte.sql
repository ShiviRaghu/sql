use companydb;

/*-- WITH cte_name AS (
    -- Define your query here
    SELECT column1, column2, ...
    FROM table_name
    WHERE condition
)
-- Main query that uses the CTE
SELECT columns
FROM cte_name;

*/



WITH HighAgeEmployees AS (
    SELECT employee_id, first_name, last_name, age
    FROM employees
    WHERE age > 18
)
SELECT employee_id, first_name, last_name
FROM HighAgeEmployees;


use joinscustomerdb;
-- Example of Recursive CTE
-- We have an Employees table with EmployeeID, ManagerID, and FirstName. Each employee is managed by another employee, forming a hierarchy. We want to find all employees in the reporting hierarchy under a specific manager, say, ManagerID = 1.


/*WITH Recursive_CTE AS (
    -- Anchor member
    SELECT column1, column2
    FROM table_name
    WHERE condition

    UNION ALL

    -- Recursive member (references Recursive_CTE)
    SELECT column1, column2
    FROM table_name
    INNER JOIN Recursive_CTE ON condition
)
SELECT *
FROM Recursive_CTE;
*/

WITH employeeHierarchy AS (
    -- Anchor member: Start from the top manager (e.g., ManagerID = 1)
    SELECT emp_id, manager_id, name, 1 AS Level
    FROM emp_aqr
    WHERE manager_id = 1
    UNION ALL

 -- Recursive member: Get employees reporting to the ones found in the previous level
    SELECT e.emp_id, e.manager_id, e.name, eh.Level + 1
    FROM emp_aqr e
    INNER JOIN employeeHierarchy eh ON e.manager_id = eh.emp_id
)
SELECT emp_id, manager_id, Level
FROM employeeHierarchy;






WITH DepartmentTotal AS (
    -- Non-recursive CTE to calculate total salary per department
    SELECT DepartmentID, SUM(Salary) AS TotalSalary
    FROM Employees
    GROUP BY DepartmentID
),
EmployeeHierarchy AS (
    -- Recursive CTE to build hierarchy for a specific department
    SELECT EmployeeID, ManagerID, FirstName, DepartmentID, 1 AS Level
    FROM Employees
    WHERE DepartmentID = 1 AND ManagerID IS NULL


    UNION ALL

    SELECT e.EmployeeID, e.ManagerID, e.FirstName, e.DepartmentID, eh.Level + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
-- Main query using both CTEs
SELECT eh.EmployeeID, eh.FirstName, eh.Level, dt.TotalSalary
FROM EmployeeHierarchy eh
JOIN DepartmentTotal dt ON eh.DepartmentID = dt.DepartmentID;





