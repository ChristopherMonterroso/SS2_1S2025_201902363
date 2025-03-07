import pandas as pd
import time
from tqdm import tqdm
from database import conectar_db

df_global = None  

def extraer_informacion(archivo):
    """Extrae información del archivo CSV sin procesarla y la almacena globalmente."""
    global df_global
    try:
        df = pd.read_csv(archivo)
        df.columns = df.columns.str.lower().str.replace(" ", "_")  # Normalizar nombres de columnas
        
        print("\nVista previa de los primeros 5 registros:\n")
        print(df.head())  
        df_global = df  
        print("\nDatos extraídos correctamente y listos para ser procesados.")

    except Exception as e:
        print(f"Error al extraer información: {e}")

def limpiar_datos(df):
    """Limpia los datos antes de insertarlos en la base de datos."""
    
    print("\nIniciando limpieza de datos...\n")
    datos_iniciales = df.shape[0]  # Cantidad de datos antes de limpiar
    
    # Normalización de columnas de texto
    for col in tqdm(df.columns, desc="Limpiando columnas"):
        if col in ["first_name", "last_name", "gender", "nationality", "pilot_name", "flight_status"]:
            df[col] = df[col].fillna("Desconocido").str.strip().str.title()
        
        if col in ["airport_country_code", "arrival_airport"]:
            df[col] = df[col].fillna("UNK").str.upper().str.strip()

    # Manejo de fechas
    df["departure_date"] = pd.to_datetime(df["departure_date"], errors="coerce") 
    registros_invalidos_fecha = df[df["departure_date"].isnull()].shape[0]
    df = df.dropna(subset=["departure_date"])  # Eliminar registros con fechas inválidas

    # Manejo de edades
    df["age"] = pd.to_numeric(df["age"], errors="coerce")  
    registros_invalidos_edad = df[df["age"].isnull()].shape[0]
    df = df.dropna(subset=["age"])  # Eliminar registros con edad inválida
    df["age"] = df["age"].astype(int) 

    # Eliminar duplicados correctamente
    df = df.drop_duplicates().reset_index(drop=True)

    datos_finales = df.shape[0] 

    print(f"Limpieza de datos completada. Datos antes: {datos_iniciales} → Datos después: {datos_finales}")
    print(f"Se eliminaron {registros_invalidos_fecha} registros por fecha inválida y {registros_invalidos_edad} por edad inválida.")

    return df

def procesar_archivo():
    """Limpia y carga el archivo CSV en la base de datos sin pedir la ruta nuevamente."""
    global df_global
    if df_global is None:
        print("Error: No se ha extraído la información. Primero ejecute la opción 3.")
        return

    conn = conectar_db()
    cursor = None  
    
    if conn:
        try:
            df = limpiar_datos(df_global)
            if df is None or df.shape[0] == 0:
                print("Proceso detenido: No hay datos limpios para cargar.")
                return

            cursor = conn.cursor()  

            print("\nProcesando datos, por favor espere...\n")
            time.sleep(1)

            for _, row in tqdm(df.iterrows(), total=df.shape[0], desc="Cargando registros"):
                cursor.execute("""
                    INSERT INTO dim_passenger (first_name, last_name, gender, nationality, age)
                    VALUES (?, ?, ?, ?, ?)""",
                    row['first_name'], row['last_name'], row['gender'], row['nationality'], row['age']
                )

                cursor.execute("""
                    INSERT INTO dim_departure_airport (airport_name, airport_country_code, country_name, airport_continent)
                    VALUES (?, ?, ?, ?)""",
                    row['airport_name'], row['airport_country_code'], row['country_name'], row['airport_continent']
                )

                cursor.execute("""
                    INSERT INTO dim_arrival_airport (airport_name)
                    VALUES (?)""",
                    row['arrival_airport']
                )

                cursor.execute("""
                    INSERT INTO dim_pilot (pilot_name)
                    VALUES (?)""",
                    row['pilot_name']
                )

                cursor.execute("""
                    INSERT INTO dim_flight_status (flight_status)
                    VALUES (?)""",
                    row['flight_status']
                )

                cursor.execute("""
                    INSERT INTO dim_departure_date (date, year, month, day)
                    VALUES (?, ?, ?, ?)""",
                    row['departure_date'], row['departure_date'].year, row['departure_date'].month, row['departure_date'].day
                )

                cursor.execute("""
                    INSERT INTO fact_flight (passenger_id, departure_date_id, departure_airport_id, arrival_airport_id, pilot_id, flight_status_id)
                    VALUES (
                        (SELECT MAX(passenger_id) FROM dim_passenger),
                        (SELECT MAX(departure_date_id) FROM dim_departure_date),
                        (SELECT MAX(departure_airport_id) FROM dim_departure_airport),
                        (SELECT MAX(arrival_airport_id) FROM dim_arrival_airport),
                        (SELECT MAX(pilot_id) FROM dim_pilot),
                        (SELECT MAX(flight_status_id) FROM dim_flight_status)
                    )"""
                )

            conn.commit()
            print("\nCarga completada con éxito.\n")

        except Exception as e:
            print(f"Error al procesar archivo: {e}")

        finally:
            if cursor:  
                cursor.close()
            conn.close()
