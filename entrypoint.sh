#!/bin/ash

FILE=/root/.ssh/id_rsa


if [[ -z $IDRSA ]]; then
    echo "RSA private key not found"
    exit
fi

if [[ -z $REPO ]]; then
    echo "BitBuckect repository not specifie"
    exit
fi

echo "-----BEGIN RSA PRIVATE KEY-----" > $FILE
echo $IDRSA | sed -e "s/.\{64\}/&\n/g" >> $FILE
echo "-----END RSA PRIVATE KEY-----" >> $FILE

chmod 0400 $FILE

eval "$(ssh-agent -s)"
ssh-add $FILE

ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts

git clone -b $BRANCH git@bitbucket.org:${REPO} /app
