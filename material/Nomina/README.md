# Nómina (padrón)

Fuente de la semilla inicial de la base.

- `Protagonistas.txt` — DNI + Nombre (tab). Solo habilita el padrón; la cuenta la crea cada uno al registrarse.
- `Educadores.txt` — DNI + Nombre (tab). Quedan marcados como educador en el padrón; **no** se les crea cuenta: la primera vez eligen alias y contraseña igual que un protagonista.

Formato:

```
Dni	Nombre
27361408	Cantarelli, Julian
```

Al levantar el contenedor / migrar, se leen estos archivos.
