import pandas as pd
import os
import pyodbc
from database import conectar_db

def ejecutar_consultas():
    """Ejecuta las consultas analíticas desde el archivo SQL y guarda los resultados en Excel."""
    conn = conectar_db()
    if not conn:
        print("Error: No se pudo conectar a la base de datos.")
        return

    try:
        with open("sql/queries.sql", "r", encoding="utf-8") as file:
            sql_script = file.read()

        consultas = sql_script.split(";")  
        resultados = {}  

        cursor = conn.cursor()

        for i, query in enumerate(consultas):
            query = query.strip()
            if query:
                print(f"Ejecutando consulta {i+1}...")
                cursor.execute(query)
                columnas = [column[0] for column in cursor.description]  
                datos = cursor.fetchall()

                # Convertir resultados a DataFrame
                df = pd.DataFrame.from_records(datos, columns=columnas)
                resultados[f"Consulta {i+1}"] = df

        cursor.close()

        
        os.makedirs("output", exist_ok=True)

        ruta_salida = "output/resultados.xlsx"
        with pd.ExcelWriter(ruta_salida, engine="xlsxwriter") as writer:
            for nombre, df in resultados.items():
                df.to_excel(writer, sheet_name=nombre[:31], index=False)  

        print(f"\nConsultas ejecutadas correctamente. Los resultados están en '{ruta_salida}'")

    except Exception as e:
        print(f"Error al ejecutar consultas: {e}")

    finally:
        conn.close()