-- Вариант 1. Вся информация в одной таблице
-- Плохой вариант, дублируется название отдела

CREATE TABLE IF NOT EXISTS Worker (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dept_name VARCHAR(100) NOT NULL,
    chief_id INTEGER REFERENCES Worker
);


-- Вариант 2. Отдельные таблицы отделов и сотрудников

CREATE TABLE IF NOT EXISTS Dept (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    chief_id INTEGER
);

CREATE TABLE IF NOT EXISTS Worker (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,    
    dept_id INTEGER REFERENCES Dept(id)
);

ALTER TABLE Dept
ADD CONSTRAINT fk FOREIGN KEY(chief_id) REFERENCES Worker(id);



