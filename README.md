# 📊 SQL SERVER DESDE CERO - GUÍA COMPLETA

**SQL Server desde Cero** es un sitio educativo completo diseñado para enseñar SQL Server desde los fundamentos hasta conceptos avanzados, con explicaciones claras, ejemplos prácticos y código listo para usar.

> *"El conocimiento es poder. El conocimiento de SQL Server es poder sobre los datos."*

---

## 🎯 ¿Qué es este Proyecto?

Este proyecto proporciona un recurso educativo gratuito para aprender SQL Server, incluyendo:

- **Documentación completa** de cada tema
- **Ejemplos de código** listos para ejecutar
- **Ejercicios prácticos** para reforzar el aprendizaje
- **Sitio web educativo** con navegación intuitiva

---

## 📚 Contenido del Curso

### Módulo 1: Fundamentos

1. **Creación de Bases de Datos**
   - Sintaxis CREATE DATABASE
   - Opciones de archivos y logs
   - Modificar y eliminar bases de datos

2. **Tablas**
   - Tipos de datos
   - Restricciones (constraints)
   - Claves primarias y foráneas
   - Columnas identity

3. **Consultas SELECT**
   - SELECT básico
   - Cláusula WHERE
   - ORDER BY
   - Funciones de agregación

### Módulo 2: Intermedio

4. **JOIN**
   - INNER JOIN
   - LEFT/RIGHT JOIN
   - FULL OUTER JOIN
   - CROSS JOIN
   - SELF JOIN

5. **Índices**
   - Tipos de índices
   - Creación y mantenimiento
   - Índices compuestos y filtrados

6. **Stored Procedures**
   - Creación de procedimientos
   - Parámetros de entrada/salida
   - Manejo de errores

### Módulo 3: Avanzado

7. **Triggers**
   - Triggers de INSERT, UPDATE, DELETE
   - Tablas inserted y deleted
   - Mejores prácticas

---

## 🗂️ Estructura del Proyecto

```
EXE-ZOOM-ATACK/
├── index.html                      # Página principal
├── docs/
│   ├── 01-creacion-base-datos.html # Documentación de BD
│   ├── 02-tablas.html              # Documentación de tablas
│   ├── 03-consultas-select.html    # (pendiente)
│   ├── 04-join.html                # (pendiente)
│   ├── 05-indices.html             # (pendiente)
│   ├── 06-stored-procedures.html   # (pendiente)
│   └── 07-triggers.html            # (pendiente)
├── examples/
│   ├── ejemplos-completos.html     # Galería de ejemplos
│   └── ejemplos-completos.sql      # Scripts SQL descargables
├── css/
│   └── styles.css                  # Estilos del sitio
├── js/
│   └── main.js                     # JavaScript del sitio
└── README.md
```

---

## 🚀 Cómo Usar este Proyecto

### Opción 1: Navegar el Sitio Web

1. Abre `index.html` en tu navegador
2. Navega por las secciones del curso
3. Haz clic en los temas para ver la documentación detallada

### Opción 2: Ejecutar los Ejemplos SQL

1. Abre SQL Server Management Studio (SSMS)
2. Conéctate a tu instancia de SQL Server
3. Abre el archivo `examples/ejemplos-completos.sql`
4. Ejecuta los scripts por secciones

### Requisitos

- **SQL Server 2016** o superior (Express, Developer, Enterprise)
- **SQL Server Management Studio (SSMS)** o **Azure Data Studio**
- Navegador web moderno (Chrome, Firefox, Edge)

---

## 📝 Ejemplos Rápidos

### Crear Base de Datos

```sql
CREATE DATABASE MiBaseDeDatos;
GO

USE MiBaseDeDatos;
GO
```

### Crear Tabla

```sql
CREATE TABLE Empleados (
    EmpleadoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE,
    Salario DECIMAL(10,2),
    FechaContratacion DATE DEFAULT GETDATE()
);
```

### Consulta SELECT con JOIN

```sql
SELECT 
    e.Nombre AS Empleado,
    d.Nombre AS Departamento,
    e.Salario
FROM Empleados e
INNER JOIN Departamentos d ON e.DepartamentoID = d.DepartamentoID
WHERE e.Salario > 50000
ORDER BY e.Salario DESC;
```

### Stored Procedure

```sql
CREATE PROCEDURE sp_ObtenerEmpleados
    @DepartamentoID INT = NULL
AS
BEGIN
    SELECT * FROM Empleados
    WHERE @DepartamentoID IS NULL 
          OR DepartamentoID = @DepartamentoID;
END
```

---

## 🎓 Metodología de Aprendizaje

### 1. Leer la Teoría
Cada tema comienza con una explicación clara del concepto.

### 2. Ver Ejemplos
Los ejemplos de código muestran la aplicación práctica.

### 3. Practicar
Los ejercicios te permiten aplicar lo aprendido.

### 4. Experimentar
Modifica los ejemplos para entender cómo funcionan.

---

## 🔧 Comandos Esenciales

### Gestión de Bases de Datos

```sql
-- Listar bases de datos
SELECT name FROM sys.databases;

-- Usar una base de datos
USE NombreBaseDeDatos;

-- Eliminar base de datos
DROP DATABASE IF EXISTS NombreBaseDeDatos;
```

### Gestión de Tablas

```sql
-- Listar tablas
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES;

-- Ver estructura de tabla
EXEC sp_help 'NombreTabla';

-- Eliminar tabla
DROP TABLE IF EXISTS NombreTabla;
```

### Consultas Comunes

```sql
-- Contar registros
SELECT COUNT(*) FROM NombreTabla;

-- Ver primeros registros
SELECT TOP 10 * FROM NombreTabla;

-- Buscar datos
SELECT * FROM NombreTabla WHERE Columna LIKE '%valor%';
```

---

## 📖 Recursos Adicionales

### Documentación Oficial

- [Microsoft SQL Server Documentation](https://docs.microsoft.com/sql/sql-server/)
- [T-SQL Reference](https://docs.microsoft.com/sql/t-sql/language-reference)
- [SQL Server Training](https://docs.microsoft.com/sql/sql-server/training/)

### Herramientas Recomendadas

- **SQL Server Management Studio (SSMS)** - IDE oficial gratuito
- **Azure Data Studio** - Editor moderno multiplataforma
- **dbatools** - Módulo de PowerShell para automatización

### Comunidades

- [SQL Server Community](https://techcommunity.microsoft.com/t5/sql-server/ct-p/SQLServer)
- [Stack Overflow - SQL Server](https://stackoverflow.com/questions/tagged/sql-server)
- [Reddit r/SQLServer](https://www.reddit.com/r/SQLServer/)

---

## 💡 Consejos para Principiantes

1. **Practica regularmente**: La consistencia es clave para aprender SQL.
2. **Comienza simple**: Domina SELECT antes de avanzar a conceptos complejos.
3. **Entiende los JOINs**: Son fundamentales para consultas relacionales.
4. **Usa aliases**: Hacen el código más legible.
5. **Prueba tus consultas**: Ejecuta por partes para depurar errores.

---

## ⚠️ Mejores Prácticas

### Seguridad

- Nunca uses `SELECT *` en producción
- Usa parámetros para prevenir SQL Injection
- Valida siempre los datos de entrada

### Rendimiento

- Indexa columnas usadas en WHERE y JOIN
- Evita funciones en columnas del WHERE
- Usa EXISTS en lugar de IN para subconsultas grandes

### Código

- Usa nombres descriptivos para tablas y columnas
- Comenta tu código SQL
- Mantén un formato consistente

---

## 🧪 Ejercicios Prácticos

### Nivel Básico

1. Crea una base de datos llamada `Biblioteca`
2. Crea tablas para `Libros`, `Socios` y `Prestamos`
3. Inserta al menos 5 registros en cada tabla
4. Consulta todos los libros disponibles

### Nivel Intermedio

1. Crea un stored procedure para registrar préstamos
2. Usa JOIN para mostrar libros con sus categorías
3. Crea una vista con el resumen de préstamos por socio

### Nivel Avanzado

1. Implementa un trigger para actualizar stock automáticamente
2. Crea índices para optimizar consultas frecuentes
3. Implementa transacciones para operaciones críticas

---

## 👨‍💻 Desarrollado por Isaac Esteban Haro Torres

**Ingeniero en Sistemas · Full Stack · Automatización · Data**

- 📧 Email: zackharo1@gmail.com
- 📱 WhatsApp: 098805517
- 💻 GitHub: https://github.com/ieharo1
- 🌐 Portafolio: https://ieharo1.github.io/portafolio-isaac.haro/

---

© 2026 Isaac Esteban Haro Torres - Todos los derechos reservados.
