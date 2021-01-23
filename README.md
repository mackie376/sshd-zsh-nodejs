# sshd-zsh-nodejs

Docker image for ZSH over SSH daemon to develop Node.js application.

## How to build

```sh
# default value
#   USER:  user
#   GROUP: user
#   UID:   1000
#   GID:   1000
#   PASS:  password

# get repository
git clone https://gitlab.creators-square.net/mackie/sshd-zsh-nodejs.git <path-to-repos>

# build
cd <path-to-repos>
docker build --build-arg USER=<user> --build-arg GROUP=<group> -t sshd-zsh-nodejs:latest .
```

## How to run

```sh
# example
docker run -it --rm -d \
  --name=node-ssh \
  --volume=${HOME}/.ssh:/home/<user>/.ssh \
  --volume=${HOME}/.config/git/config:/home/<user>/.config/git/config \
  --volume=${HOME}/.gnupg:/home/<user>/.gnupg \
  --publish=10000:22 \
  sshd-zsh-nodejs:latest
```
