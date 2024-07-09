# Scripts

## Backup script setup

Create the .env file from the .env.example file and fill in values.

```sh
cp .env.example .env
```

Create the config.cnf file from the config.cnf.example file and fill in values.

```sh
cp .env.example .env
```

Install s3cmd

```sh
sudo apt install -y s3cmd
```

Add Amazon AWS access and secret keys to s3cmd

```sh
s3cmd --configure
```

Run backup script

```sh
./backup.sh
```