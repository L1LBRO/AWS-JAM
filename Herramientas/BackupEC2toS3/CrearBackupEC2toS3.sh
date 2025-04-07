 #!/bin/bash
 
 #Backup hacia el bucket
BUCKET_NAME="nombre_bucket"   #Define el nombre del bucket de S3 donde se subirá el archivo
FOLDER_PATH="/var/www/html"   #Ruta del directorio que se desea respaldar en este caso como se quiere hacer un backup de la página web se copia todo el html.
TIMESTAMP=$(date "+%Y_%m_%d-%H:%M")   #Genera una marca de tiempo (formato YYYY_MM_DD-HH:MM) para distinguir los backups.
BACKUP="/tmp/backup_${TIMESTAMP}.zip"   #Ruta y nombre del archivo ZIP que se creará en la carpeta temporal /tmp

 #Creación del zip
zip -r "$BACKUP" "$FOLDER_PATH"   #Se utiliza el comando zip -r para comprimir de manera recursiva (que copie todo lo que hay dentro de ese directorio) el contenido del directorio definido en FOLDER_PATH.

#Comprobar la creación del zip

 if [ -f "$BACKUP" ]; then     #Se verifica si el archivo ZIP fue creado correctamente comprobando si existe (-f).
     echo "Se creó el backup : $BACKUP"  #Si existe, se imprime un mensaje indicando que se generó el archivo

 #Mandar el backup al bucket usando el CLI
aws s3 cp "$BACKUP" "s3://$BUCKET_NAME/"   #Utiliza el comando aws s3 cp para copiar el archivo ZIP al bucket de S3 indicado.
                                                                  #aws-cli debe estar configurado previamente con las credenciales necesarias.

 #Comprobar que se envió de manera correcta
if [ $? -eq 0  ]; then   #Verifica si el comando anterior (aws s3 cp) se ejecutó correctamente. $? almacena el código de salida del último comando ejecutado: 0: Éxito. Distinto de 0: Error.
      echo "Backup subido a $BUCKET_NAME"   #Si la subida fue exitosa, se imprime un mensaje confirmándolo.

#Eliminar el backup local
       rm "$BACKUP"   #Si el archivo fue subido correctamente a S3, se elimina el archivo ZIP local para liberar espacio.
 else
       echo "Error al subir el backup"   #Si la subida a S3 falla
 fi
 else
       echo "Error al crear el zip"   #Si no se pudo crear el ZIP
fi
