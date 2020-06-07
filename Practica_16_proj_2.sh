#! /bin/bash

#https://github.com/umerz999/Practica_16_proj_2.git

# Comproba si UID = 0 (root).
if [[ "${UID}" -eq 0 ]]
then
if [[ "$#" -lt 1 ]]
then
	echo " Debes introducir Usuario y nombre real"
	echo "./ programa [Usuario] [Nombre]"
		exit 1
fi

# Demana 'nickname' de l'usuari.
USER="$1"

# Demana nom real per l'usuari.
COMMENT="$2"

# Genera un password.
#PASSWORD=$(date | sha256sum | cut )
PASS=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 11 | head -n 1)

# Crear usuario.
useradd -m ${USER} -c ${COMMENT}


#echo "${USER}":${PASSWORD} | chpasswd

if [[ ${?} -ne 0 ]]
then
echo "La creación de usuario es errónea"
		 exit 1
fi

# Assigna password.
echo -e "$PASS\n$PASS" | passwd ${USER}  &> /dev/null


if [[ ${?} -ne 0 ]]
then
echo "La creación de password es errónea"
		 exit 1
fi

# Obliga a canviar la pass al primer login.
passwd -e ${USER}

# Mostra variables.
echo "El usuario es $USER, y su contraseña es $PASS."
else
  echo 'Debes ser root para utilizar el programa.'
		exit 1
fi
