import pyodbc
from config import DB_CONFIG

def conectar_db():
    """Establece conexión con la base de datos."""
    try:
        conn = pyodbc.connect(
            f"DRIVER={{SQL Server}};"
            f"SERVER={DB_CONFIG['server']};"
            f"DATABASE={DB_CONFIG['database']};"
            f"UID={DB_CONFIG['user']};"
            f"PWD={DB_CONFIG['password']};"
            "Trusted_Connection=yes;"
        )
        return conn
    except Exception as e:
        print(f"Error al conectar con la base de datos: {e}")
        return None

def borrar_modelo():
    """Elimina todas las tablas de la base de datos."""
    conn = conectar_db()
    if conn:
        cursor = conn.cursor()
        try:
            cursor.execute("DROP TABLE IF EXISTS fact_flight, dim_passenger, dim_departure_date, dim_departure_airport, dim_arrival_airport, dim_pilot, dim_flight_status")
            conn.commit()
            print("Modelo eliminado correctamente.")
        except Exception as e:
            print(f"Error al borrar modelo: {e}")
        finally:
            cursor.close()
            conn.close()

def crear_modelo():
    """Crea las tablas en la base de datos."""
    conn = conectar_db()
    if conn:
        cursor = conn.cursor()
        try:
            sql_script = open("sql/modelo.sql", "r").read()
            cursor.execute(sql_script)
            conn.commit()
            print("Modelo creado correctamente.")
        except Exception as e:
            print(f"Error al crear modelo: {e}")
        finally:
            cursor.close()
            conn.close()
