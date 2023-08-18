# petpartners-automation
This project is for automation testing

## setup environment

1) Java

install Java JDK 11
configure the environment variable
JAVA_HOME=java_jdk_path
PATH=java_jdk_path/bin

2) Gradle

download gradle [gradle binary-only](https://gradle.org/releases/)
install gradle 6 or greater
GRADLE_HOME= path/gradle
PATH=path/gradle/bin

3) IntelliJ Idea - Community Edition (free)

download the [IntelliJ Idea Community](https://www.jetbrains.com/idea/download/#section=windows)
install plugin: cucumber for java and gherkins

4) Git

install git for windows [git Windows](https://gitforwindows.org/)
```
git clone https://github.com/petpartners/petpartners-automation.git
```

## execute automation test cases

the module: petpartners-common is a common utils then we need to build it:
```
go to commons
cd path:\petpartners-automation\petpartners-common
```
execute
```
gradle build
```
then we have the specific modules 

1) petpartners-api-pet
2) petpartners-api-quote
3) petpartners-ui-akc
4) petpartners-ui-orca
5) petpartners-ui-ppi

and the way to run the test is:

```
go to specific module, 
i.e cd path:\petpartners-automation\petpartners-ui-orca
```
execute:
```
gradle cucumber -Psuite=@Sanity -PpropertyFile=staging.properties
```
in order to generate the report
```
gradle report
```

## execute using docker & selenium grid

1) have installed docker and docker-compose

2) configure the .env file
```
SUITE=@14353   <---------- test tu executed
ENVIRONMENT=qa.properties  <---------- environment to use
PROJECT=petpartners-ui-orca  <---------- project to use
BROWSER=grid_chrome <--------------- browser
GENERATE_GIF_IMAGE=false <------------------- generate gif image
EXCLUDE=" and not @Bug"  <------------- exclude test using the @Bug
```

Note
3) after start the docker browser execute the next command in order to copy the external files needed by some automation test
```
 docker cp $PATH\petpartners-automation firefox:/tmp/petpartners-automation
 docker cp $PATH\petpartners-automation chrome:/tmp/petpartners-automation
 docker cp $PATH\petpartners-automation edge:/tmp/petpartners-automation
```

4) go to petpartners-automation by console

5) execute the command to prepare selenium grid and browser
```
docker-compose -f petpartners-automation.yaml up chrome firefox edge selenium-hub
```
6) build the automation project
```
docker-compose -f petpartners-automation.yaml build
```
7) run the automation project
```
docker-compose -f petpartners-automation.yaml up automation-petpartners
```

## for database tmp fix

we are having problems with : The server selected protocol version TLS10 is not accepted by security

https://www.java.com/en/jre-jdk-cryptoroadmap.html

in order to have a temporal fix we need to modify the java.security file in our machines

- jre/lib/security/java.security
- conf/security/java.security

we need remove the: TLSv1

```
jdk.tls.disabledAlgorithms=SSLv3, TLSv1.1, RC4, DES, MD5withRSA, \
    DH keySize < 1024, EC keySize < 224, 3DES_EDE_CBC, anon, NULL, \
    include jdk.disabled.namedCurves
```

## parallel execution with docker by project

```
docker-compose -f petpartners-automation-parallel.yaml up -d selenium-hub chrome --scale chrome=5
```
copy files
```
 docker cp $PATH\petpartners-automation petpartners-automation-chrome-1:/tmp/petpartners-automation
 docker cp $PATH\petpartners-automation petpartners-automation-chrome-2:/tmp/petpartners-automation
 docker cp $PATH\petpartners-automation petpartners-automation-chrome-3:/tmp/petpartners-automation
 docker cp $PATH\petpartners-automation petpartners-automation-chrome-4:/tmp/petpartners-automation
 docker cp $PATH\petpartners-automation petpartners-automation-chrome-5:/tmp/petpartners-automation
```
build the image
```
docker-compose -f petpartners-automation-parallel.yaml build
```
start the container and test
```
docker-compose -f petpartners-automation-parallel.yaml up automation-petpartners-ui-orca automation-petpartners-ui-akc automation-petpartners-ui-ppi automation-petpartners-api automation-petpartners-ui-paw-some
```

