# docker-lein-mvn

Dockerfile with the followings:

- Bash
- Java 8 JDK
- Maven*
- Leiningen

## Maven Artifactory
A *Dockerfile* buildelésekor renderelésre kerül a *settings-template.xml* fájl, ami azt a célt szolgálja, hogy a majd futó konténerben lévő Maven milyen távoli tárhelyről próbálja meg letölteni az alkalmazás függőségeit.

A hivatalos [Maven Central](https://repo.maven.apache.org/maven2/) tárhelyhez való közvetlen kapcsolódás helyett beiktatásra került a [JFrog Artifactory](https://jfrog.com/open-source/), ami képes gyorsítótárazni a hivatalos tárhelyről már egyszer letöltött függőségeket.

Ahhoz, hogy a saját Maven kliens az Artifactory szerverhez kapcsolódjon, módosítani kell a `${HOME}/.m2/settings` fájl tartalmát.

A távoli Maven repository elérése és a `${HOME}/.m2/settings.xml` fájl a *Dockerfile* buildelésének idejében paraméterezhető:

**Artifactory kikapcsolása**

`docker build --build-arg NO_ARTIFACTORY=true .`

Csak `true` érték esetén lép életbe a kapcsoló!


**Artifactory elérésének megadása**

`docker build --build-arg ARTIFACTORY_ADDRESS=${host}:${port} .`


Enjoy.
