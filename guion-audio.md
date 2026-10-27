# Apoyo para la reflexión personal en MP3

Graba con tu voz después de realizar la práctica. Adapta el texto a lo que observaste; no presentes resultados sin haberlos comprobado. Este guion tiene una duración orientativa de 75–100 segundos a ritmo pausado. La duración válida es la del archivo grabado: comprueba que alcance al menos 60 segundos.

> En esta semana aprendí cómo Docker administra los datos de una base PostgreSQL y por qué es necesario separar el almacenamiento del contenedor. Primero creé un servidor, una base llamada test y una tabla customer. La tabla contenía un identificador, un nombre completo y un estado. Después inserté un registro para comprobar qué ocurría al eliminar el contenedor.
>
> En la primera parte, el directorio de datos estaba dentro de la capa escribible del contenedor. Al eliminarlo y crear otro con el mismo nombre, la base ya no estaba disponible. Esto me ayudó a entender que reutilizar un nombre no significa recuperar los datos anteriores.
>
> En la segunda parte utilicé un volumen llamado pgdata. Después de eliminar el contenedor, asocié ese mismo volumen a un contenedor nuevo. Al consultar la base, pude comprobar que la tabla y el registro seguían disponibles.
>
> También aprendí que detener un contenedor es diferente de eliminarlo y que la imagen oficial puede crear volúmenes anónimos. Por eso es importante revisar dónde se guardan realmente los archivos. Finalmente, entendí que un volumen aporta persistencia, pero no sustituye una copia de seguridad. Para proteger una base también se necesitan respaldos y comprobar que se puedan restaurar.

## Comprobación antes de entregar

1. Sustituye las frases por tus propias explicaciones y menciona un resultado real.
2. Graba al menos 70 segundos para tener margen.
3. Exporta como MP3; cambiar la extensión de otro formato no lo convierte a MP3.
4. Reproduce el archivo, verifica que la voz sea clara y que la duración sea ≥60 segundos.
5. Adjunta el archivo a la entrega de la asignatura.