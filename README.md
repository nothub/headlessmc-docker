## headlessmc-docker

[container image](https://hub.docker.com/r/n0thub/headlessmc)
for [3arthqu4ke/HeadlessMc](https://github.com/3arthqu4ke/HeadlessMc)

---

### Usage

```sh
# use volumes to persist mc and hmc data
volumes="-v ${PWD}/mc:/work/.minecraft -v ${PWD}/hmc:/work/HeadlessMC"

# show hmc help
docker run --rm headlessmc:latest "help"

# msa login
docker run --rm ${volumes} headlessmc:latest "login" "<username>" "<password>"

# download mc
docker run --rm ${volumes} headlessmc:latest "download" "1.19.4"

# download fabric
docker run --rm ${volumes} headlessmc:latest "fabric" "1.19.4"

# install mod
mkdir -p mc/mods
cp mymod.jar mc/mods/

# define server
echo "hmc.gameargs=--server 127.0.0.1 --port 25565" >> hmc/config.properties

# show available mc versions
docker run --rm ${volumes} headlessmc:latest "versions"

# launch fabric
docker run -it --rm ${volumes} headlessmc:latest "launch" "fabric-loader-0.14.22-1.19.4" "-commands"
```
