# ¿Cómo fue diseñado este backend?

Este backend está cumpliendo con un requerimiento, donde a través de una API externa (randomuser.org) se obtienen una serie de datos de usuarios (ficticios o reales), para realizar éstas llamadas remotas se emplea la gema `http`.

Posterior a la obtención de estos datos, se procede a ser almacenados en caché, para esto se utilizó Redis para gestionar el caching de estos datos.

La obtención de estos datos son provistos a través de un worker que se ejecuta cada 45 segundos, el vencimiento de la caché es de 1 minuto, pero el worker va a operar antes (con una ventanda de 15 segundos), para que, en caso de no tener datos de la API externa por alguna razón, bien sea esta conocida o no, se haga la "renovación" de los mismos datos, que serán los últimos que se encuentran en la caché, evitando pérdida de datos y este proceso sea transparente al usuario.

Las tecnologías utilizadas:

- Ruby 2.6.5
- Rails 6.0.3.1
- Redis 6.0
- Docker y docker-compose
- SQLite

Plataforma de despliegue: Amazon Web Services: una instancia EC2 `t2.micro` disponible en la `free tier`

Para descargar el repo deberá digitar en su cónsola de preferencia (bash, zsh), el siguiente comando `git`

```bash
git clone https://github.com/yescorihuela/rails-firebase-auth-users.git
```

Posterior al clonado de repositorio, deberá entrar al directorio del repositorio descargado:

```bash
cd rails-firebase-auth-users
```

Luego deberá ejecutar el siguiente comando `docker`:

```bash
docker-compose up --build
```

Al finalizar y quedar todos los servicios arriba deberá ejecutar los siguientes comandos dentro del contenedor que tiene el backend.

```bash
docker-compose exec app_backend rails db:create # Para crear la base de datos
docker-compose exec app_backend rails db:migrate # Para generar tablas
docker-compose exec app_backend rails db:seed # Para crear un usuario predeterminado
```

---

# Decisiones de diseño

- En un principio se implementa JWT para validación de usuarios, sin embargo se determinó que no era posible a través de este método, validar el token procedente del frontend, dado a que los tokens generados desde Firebase, son generados con certificados x509, por lo tanto aunque teniendo las llaves públicas y privadas no es posible validar la firma del token.

- Se utiliza otro worker para actualizar cada 30 minutos los certificados x509 procedentes de Google, basado igualmente en los servicios suministrados vía Sidekiq/Redis.

---

# ¿Qué faltó?
Éste apartado es principalmente para sincerar lo que faltó en el desarrollo, lo cual le otorga más transparencia al proceso de desarrollo y no toma por sorpresa al evaluador.

- El testing de los workers.
- La simulación de requests fallidos a la API externa, en todo momento se hace requests a la API externa y aunque no responda con un código HTTP satisfactorio (OK o 200), se continúa indefinidamente realizando requests a la API externa y renovando el tiempo de vigencia de los últimos datos.