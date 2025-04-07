En este script se explicará como crear un backup de una instancia web en EC2 hacia un bucket S3

Para empezar a crear se deben añadir las credenciales de la API de AWS a la instancia desde la que se van a hacer las backups

Las credenciales se encuentran en el AwsDetails. Para acceder hay que presionar en "Show" en AWS ClI

Estas credenciales se deben guardar en ~/.aws/credentials tal cual a como indica Amazon básicamente hay que hacer un copia-pega de esas credenciales en el fichero que se crea

Se debe crear el fichero con sudo obligatorio ya que se esta creando un ficero oculto al cuál solo el script podrá acceder.

Antes de ir con el script se debe instalar en la instancia "AWS-CLI" para que el script pueda acceder a ese fichero oculto de credenciales.

El comando de instalación es el siguiente: Sudo apt install aws-cli.

Una vez se ha instalado el cli se debe configurar la región, el formato de salida y las claves.

El comando que se debe ejecutar es: aws configure. Este comando pedirá aws_access_key_id, aws_secret_access_key, region (La región del laboratorio, que se encuentra al final del todo en AWS-Details.) y el formato de salida (Json, Text, XML etc..)
