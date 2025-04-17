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

# install mods
mkdir -p mc/mods
cp mymod.jar mc/mods/

# launch and join 10.0.0.42:9001
docker run -it --rm ${volumes} -e "ADDR=10.0.0.42" -e "PORT=9001" n0thub/headlessmc:latest launch 'fabric:1.21.5'
```

Some versions will not join a server while the `AccessibilityOnboardingScreen` is opened.
Make sure to set `onboardAccessibility` to `false` in `mc/options.txt` or use a [mod](https://github.com/nothub/headlessbot/blob/6a5395956258e4dc3f2b519dd2dd032ac0304644/src/main/java/lol/hub/headlessbot/Mod.java#L62) handle the ui.
