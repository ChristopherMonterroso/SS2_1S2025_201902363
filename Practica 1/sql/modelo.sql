-- CREACIÓN DE TABLAS

CREATE TABLE dim_passenger (
    passenger_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    nationality VARCHAR(50),
    age INT  
);

CREATE TABLE dim_departure_date (
    departure_date_id INT IDENTITY(1,1) PRIMARY KEY,
    date DATE,
    year INT,
    month INT,
    day INT
);

CREATE TABLE dim_departure_airport (
    departure_airport_id INT IDENTITY(1,1) PRIMARY KEY,
    airport_name VARCHAR(100),
    airport_country_code VARCHAR(10),
    country_name VARCHAR(100),
    airport_continent VARCHAR(50),
    comments TEXT
);

CREATE TABLE dim_arrival_airport (
    arrival_airport_id INT IDENTITY(1,1) PRIMARY KEY,
    airport_name VARCHAR(100)
);

CREATE TABLE dim_pilot (
    pilot_id INT IDENTITY(1,1) PRIMARY KEY,
    pilot_name VARCHAR(100)
);

CREATE TABLE dim_flight_status (
    flight_status_id INT IDENTITY(1,1) PRIMARY KEY,
    flight_status VARCHAR(50)
);

CREATE TABLE fact_flight (
    flight_id INT IDENTITY(1,1) PRIMARY KEY,
    passenger_id INT,
    departure_date_id INT,
    departure_airport_id INT,
    arrival_airport_id INT,
    pilot_id INT,
    flight_status_id INT,
    FOREIGN KEY (passenger_id) REFERENCES dim_passenger(passenger_id),
    FOREIGN KEY (departure_date_id) REFERENCES dim_departure_date(departure_date_id),
    FOREIGN KEY (departure_airport_id) REFERENCES dim_departure_airport(departure_airport_id),
    FOREIGN KEY (arrival_airport_id) REFERENCES dim_arrival_airport(arrival_airport_id),
    FOREIGN KEY (pilot_id) REFERENCES dim_pilot(pilot_id),
    FOREIGN KEY (flight_status_id) REFERENCES dim_flight_status(flight_status_id)
);
