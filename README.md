## headlessmc-docker

[container image](https://hub.docker.com/r/n0thub/headlessmc)
for [3arthqu4ke/HeadlessMc](https://github.com/3arthqu4ke/HeadlessMc)

---

### Usage

```sh
# show hmc help
docker run --rm n0thub/headlessmc:latest 'help'

# use volumes to persist mc and hmc data
volumes="-v ${PWD}/mc:/work/.minecraft -v ${PWD}/hmc:/work/HeadlessMC"

# msa login (interactive)
docker run -it --rm ${volumes} n0thub/headlessmc:latest 'login <mail>'

# download mc
docker run --rm ${volumes} n0thub/headlessmc:latest 'download 1.20.6'

# launch client and join server
docker run -it --rm ${volumes} -e "ADDR=10.0.0.42" -e "PORT=9001" n0thub/headlessmc:latest 'launch 1.20.6'

# the image contains all required java versions
docker run --rm ${volumes} n0thub/headlessmc:latest 'download 1.12.2'
docker run --rm ${volumes} n0thub/headlessmc:latest 'download 1.19.4'
docker run --rm ${volumes} n0thub/headlessmc:latest 'download 1.21'

# download fabric
docker run --rm ${volumes} n0thub/headlessmc:latest 'fabric 1.20.6'

# install mods
mkdir -p mc/mods
cp mymod.jar mc/mods/

# show available mc versions
docker run --rm ${volumes} n0thub/headlessmc:latest 'versions'

# launch fabric
docker run -it --rm ${volumes} -e "ADDR=10.0.0.42" n0thub/headlessmc:latest 'launch 0 -id'
```

Some versions will not join a server while the `AccessibilityOnboardingScreen` is opened.
Make sure to prepare the client accordingly or use a [mod](https://github.com/nothub/headlessbot/blob/6a5395956258e4dc3f2b519dd2dd032ac0304644/src/main/java/lol/hub/headlessbot/Mod.java#L62) to close the screen.
