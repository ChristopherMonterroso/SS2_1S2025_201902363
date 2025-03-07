##  **Instalación y Configuración**

### 1. **Crear y Activar un Entorno Virtual**

```bash
python -m venv env

env\Scripts\activate     # Windows
```

### 2. **Instalar Dependencias**

<pre class="!overflow-visible" data-start="2708" data-end="2751"><div class="overflow-y-auto p-4" dir="ltr"><code class="!whitespace-pre language-bash"><span>pip install -r requirements.txt
</span></code></div></div></pre>

### 3.**Configurar la Conexión a SQL Server**

`config.py`

<pre class="!overflow-visible" data-start="2863" data-end="3069"><div class="overflow-y-auto p-4" dir="ltr"><code class="!whitespace-pre language-python"><span>DATABASE_CONFIG = {
    'driver': '{ODBC Driver 17 for SQL Server}',
    'server': 'servidor',
    'database': 'Vuelos',
    'username': 'usuario',
    'password': 'contraseña',
}
</span></code></div></div></pre>

## **Uso de la Aplicación**

Ejecutar el menú principal con:

python main.py
</span></code></div></div></pre>

###  **Opciones del Menú**


| Opción | Descripción                                      |
| ------- | ------------------------------------------------- |
| `1`     | Borrar el modelo de base de datos                 |
| `2`     | Crear el modelo de base de datos                  |
| `3`     | Extraer información de un archivo CSV            |
| `4`     | Limpiar y cargar datos en la base de datos        |
| `5`     | Ejecutar consultas analíticas y guardar en Excel |
| `6`     | Salir                                             |

## **Consultas Analíticas**

Las consultas están definidas en **`sql/queries.sql`** y se ejecutan con la opción `5` del menú.
Los resultados se guardan en **`output/resultados.xlsx`**.

## **Datos**


| **Archivo**              | **Descripción**                                            |
| ------------------------ | ----------------------------------------------------------- |
| `output/resultados.xlsx` | Contiene los resultados de las consultas en hojas separadas |
| `data/Vuelos.csv`        | Archivo fuente de datos para la carga                       |

## **Tecnologías Usadas**

* **Python 3.8+**
* **SQL Server**
* **Pandas**
* **ODBC Driver 17**
* **XlsxWriter**
