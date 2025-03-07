import sys
from database import borrar_modelo, crear_modelo
from queries import ejecutar_consultas
from etl import extraer_informacion, procesar_archivo

def menu():
    archivo_csv = None  # Variable para almacenar la ruta del archivo

    while True:
        
        print("\nMenú Principal - ETL")
        print("=====================================")
        print("1. Borrar el modelo existente")
        print("2. Crear nuevo modelo de datos")
        print("3. Extraer información de archivo CSV")
        print("4. Limpiar y cargar datos")
        print("5. Ejecutar consultas analíticas")
        print("6. Salir")
        print("=====================================")
        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            borrar_modelo()
        elif opcion == "2":
            crear_modelo()
        elif opcion == "3":
            archivo_csv = input("Ingrese la ruta del archivo CSV: ")
            extraer_informacion(archivo_csv)
        elif opcion == "4":
            if archivo_csv:
                procesar_archivo()
            else:
                print("Error: Primero debe extraer la información con la opción 3.")
        elif opcion == "5":
            ejecutar_consultas()
        elif opcion == "6":
            print("Saliendo del programa...")
            break
        else:
            print("Opción no válida, intente nuevamente.")

if __name__ == "__main__":
    menu()