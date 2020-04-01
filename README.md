# docker-compose-tutorial

Как использовать:

## Построить контейнер 

```bash
ONBUILD_VAR_LOCAL=onbuild-variable-content   docker-compose -f docker-compose.build.yml build --no-cache
```


Пример вывода:

```
Building sample
Step 1/6 : FROM ubuntu
 ---> 4e5021d210f6
Step 2/6 : ARG ONBUILD_VARIABLE
 ---> Running in 828f68f1690b
Removing intermediate container 828f68f1690b
 ---> d8ec63d32434
Step 3/6 : RUN env
 ---> Running in 6f81badb6c9f
HOSTNAME=6f81badb6c9f
HOME=/root
ONBUILD_VARIABLE=onbuild-variable-content
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/
Removing intermediate container 6f81badb6c9f
 ---> 5fd74f3487f5
Step 4/6 : RUN echo "ONBUILD=${ONBUILD_VARIABLE}"
 ---> Running in bcf51eb277e1
ONBUILD=onbuild-variable-content
Removing intermediate container bcf51eb277e1
 ---> 22f5b89c148f
Step 5/6 : RUN echo "${ONBUILD_VARIABLE}" > /tmp/build-var
 ---> Running in aa28c0a516e0
Removing intermediate container aa28c0a516e0
 ---> 9e2e14d00a24
Step 6/6 : CMD ["bash", "-c", "echo '----[ Env ] ----' && env | grep RUNTIME &&  echo '----[ Build variable ]----' && cat /tmp/build-var"]
 ---> Running in 13a3fd23e405
```

Вот эта строка: `ONBUILD_VARIABLE=onbuild-variable-content` как бы главная, она означает, что переменная приползла в докер-композ


Все, мы построили образ.

## Запуск контейнера

Запускаем с настройкой:

```bash
RUNTIME_VAR_LOCAL=runtime-variable-content docker-compose -f docker-compose.run.yml up
```

На выходе имеем:

```
sample-image | ----[ Env ] ----
sample-image | RUNTIME_VARIABLE=runtime-variable-content
sample-image | ----[ Build variable ]----
sample-image | onbuild-variable-content
```

## Как вынести переменные в файлы

### docker-compose.build.yml

Создаем `build.env'
```
ONBUILD_VAR_LOCAL=onbuild-separate
```

Запускаем

```bash
cp build.env .env
docker-compose -f docker-compose.build.yml build 
rm -f .env
```


### docker-compose.run.yml

Создаем `run.env'

```bash
RUNTIME_VAR_LOCAL=runtime-separate
```


#### Вариант А

```bash
cp run.env .env
docker-compose -f docker-compose.run.yml up 
rm -f .env
```


#### Вариант Б

```bash
docker-compose  -f  docker-compose.run-envfile.yml up
```