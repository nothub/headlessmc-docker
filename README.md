## headlessmc-docker

[container image](https://hub.docker.com/r/n0thub/headlessmc)
for [3arthqu4ke/HeadlessMc](https://github.com/3arthqu4ke/HeadlessMc)

---

### Usage

```sh
# show hmc help
docker run --rm n0thub/headlessmc:latest "help"

# use volumes to persist mc and hmc data
volumes="-v ${PWD}/mc:/work/.minecraft -v ${PWD}/hmc:/work/HeadlessMC"

# msa login
docker run --rm ${volumes} n0thub/headlessmc:latest "login" "<mail>" "<pass>"

# download mc
docker run --rm ${volumes} n0thub/headlessmc:latest "download" "1.20.4"

# download fabric
docker run --rm ${volumes} n0thub/headlessmc:latest "fabric" "1.20.4"

# show available mc versions
docker run --rm ${volumes} n0thub/headlessmc:latest "versions"

# install mod
mkdir -p mc/mods
cp mymod.jar mc/mods/

# set container env vars to configure target server
envvars="-e 'ADDR=10.0.0.42' -e 'PORT=9001'"

# launch specified mc version and join server
docker run -it --rm ${volumes} ${envvars} n0thub/headlessmc:latest "launch" "1.20.4"
```

Some versions will not join a server while the `AccessibilityOnboardingScreen` is opened.
Make sure to prepare the client accordingly.
