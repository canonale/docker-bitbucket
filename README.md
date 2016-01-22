# docker-bitbucket

Docker image to download git private repository in a alpine image

This image is ideal for serving application files without accessing the server. 
Only run one machine and link with your Stack

No password.


## Add public key in Bitbucket.org

Obviously, you must have an account in **Bitbucket**.

Go to account settings:

    https://bitbucket.org/account/user/[USERNAME]

And then click into *SSH keys*.

![List of SSH keys][1]

Click in *Add key* and paste your public key

![Paste the public key][2]


## Generate an specific key for Bitbucket

Use this command:

    >_ ssh-keygen -t rsa -b 4096 -C “email” -f filename

And then you have 2 files:

1. **filename**, this is the private key.
2. **filename.pub**, this is the public key.

If you want generate the IDRSA environment variable to connect to bitbucket.org without password
you might use:

    >_ grep "^--" -v filename | paste -s -d ""
    >_ #If you want set clipboard
    >_ grep "^--" -v filename | paste -s -d "" | xclip -sel clip 


## Environment variables

- **IDRSA** this is mandatory variable with the private RSA key. This var should be 
in one line and whiout the rsa marks (*-----BEGIN|END RSA PRIVATE KEY-----*).
- **REPO** this is the reposotiry’s name without domain (deploymentbox/my-repo.git)
- **BRANCH** this var is optional and is the name of the clone branch. By default is *master*.
- **APP** this is the clone path folder. If you must link with other container with a specific path you can change it

## Run an example

This example download a repository and copy in a local folder:

    >_ mkdir /tmp/django-jquery 
    >_ IDRSA=$(grep "^--" -v id_rsa | paste -s -d "")
    >_ docker run --rm -v /tmp/django-jquery:/app -e IDRSA=$IDRSA \
    -e REPO=massimilianoravelli/django-jquery canonale/bitbucket 

Deploy one PHP application:

    >_ docker run -v /var/www/html/ -e APP=/var/www/html/ \
    -e IDRSA=$IDRSA -e REPO=user/my-php-code.git \
    --name php-repository canonale/bitbucket 
    >_ # PHP-Apache container use /var/www/html/ to run 
    >_ docker run --volumes-from php-repository php:5.5-apache





[1]: https://s3-us-west-2.amazonaws.com/blog-canonale/settings.png
[2]: https://s3-us-west-2.amazonaws.com/blog-canonale/key.png
