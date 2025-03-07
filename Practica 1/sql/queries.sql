-- Total de registros en fact_flight
SELECT 
    (SELECT COUNT(*) FROM dim_passenger) ,
    (SELECT COUNT(*) FROM dim_departure_date) ,
    (SELECT COUNT(*) FROM dim_departure_airport) ,
    (SELECT COUNT(*) FROM dim_arrival_airport) ,
    (SELECT COUNT(*) FROM dim_pilot) ,
    (SELECT COUNT(*) FROM dim_flight_status) ,
    (SELECT COUNT(*) FROM fact_flight) ;


-- Porcentaje de pasajeros por género
SELECT gender, COUNT(*) * 100.0 / (SELECT COUNT(*) FROM dim_passenger) AS porcentaje
FROM dim_passenger
GROUP BY gender;

-- Nacionalidades con su mes y año de mayor fecha de salida
WITH Ranking AS (
    SELECT 
        dim_passenger.nationality, 
        dim_departure_date.year, 
        dim_departure_date.month, 
        COUNT(*) AS total_vuelos,
        ROW_NUMBER() OVER (PARTITION BY dim_passenger.nationality ORDER BY COUNT(*) DESC) AS fila
    FROM dim_passenger
    JOIN fact_flight ON dim_passenger.passenger_id = fact_flight.passenger_id
    JOIN dim_departure_date ON fact_flight.departure_date_id = dim_departure_date.departure_date_id
    GROUP BY dim_passenger.nationality, dim_departure_date.year, dim_departure_date.month
)
SELECT nationality, year, month, total_vuelos
FROM Ranking
WHERE fila = 1
ORDER BY total_vuelos DESC;


-- Número de vuelos por país de salida
SELECT dim_departure_airport.country_name, COUNT(*) AS total_vuelos
FROM dim_departure_airport
JOIN fact_flight ON dim_departure_airport.departure_airport_id = fact_flight.departure_airport_id
GROUP BY dim_departure_airport.country_name
ORDER BY total_vuelos DESC;

-- Top 5 aeropuertos con más pasajeros
SELECT TOP 5 airport_name, COUNT(*) AS total_pasajeros
FROM dim_departure_airport
JOIN fact_flight ON dim_departure_airport.departure_airport_id = fact_flight.departure_airport_id
GROUP BY airport_name
ORDER BY total_pasajeros DESC;

-- Número de vuelos por estado de vuelo
SELECT flight_status, COUNT(*) AS total_vuelos
FROM dim_flight_status
JOIN fact_flight ON dim_flight_status.flight_status_id = fact_flight.flight_status_id
GROUP BY flight_status;

-- Top 5 países más visitados
SELECT TOP 5 dim_departure_airport.country_name, COUNT(*) AS total_visitas
FROM dim_departure_airport
JOIN fact_flight ON dim_departure_airport.departure_airport_id = fact_flight.departure_airport_id
GROUP BY dim_departure_airport.country_name
ORDER BY total_visitas DESC;

-- Top 5 continentes más visitados
SELECT TOP 5 airport_continent, COUNT(*) AS total_visitas
FROM dim_departure_airport
JOIN fact_flight ON dim_departure_airport.departure_airport_id = fact_flight.departure_airport_id
GROUP BY airport_continent
ORDER BY total_visitas DESC;

-- Top 5 edades por género con más vuelos
SELECT TOP 5 age, gender, COUNT(*) AS total_vuelos
FROM dim_passenger
JOIN fact_flight ON dim_passenger.passenger_id = fact_flight.passenger_id
GROUP BY age, gender
ORDER BY total_vuelos DESC;

-- Número de vuelos por mes y año
SELECT year, month, COUNT(*) AS total_vuelos
FROM dim_departure_date
JOIN fact_flight ON dim_departure_date.departure_date_id = fact_flight.departure_date_id
GROUP BY year, month
ORDER BY year DESC, month DESC;
