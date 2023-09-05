## headlessmc-docker

[container image](https://hub.docker.com/r/n0thub/headlessmc)
for [3arthqu4ke/HeadlessMc](https://github.com/3arthqu4ke/HeadlessMc)

---

### Usage

```sh
volumes="-v ${PWD}/mc:/work/.minecraft -v ${PWD}/hmc:/work/HeadlessMC"
docker run --rm headlessmc:latest "help"
docker run --rm ${volumes} headlessmc:latest "login" "<username>" "<password>"
docker run --rm ${volumes} headlessmc:latest "download" "1.19.4"
docker run --rm ${volumes} headlessmc:latest "fabric" "1.19.4"
mkdir -p mc/mods
cp mymod.jar mc/mods/
docker run --rm ${volumes} headlessmc:latest "versions"
docker run -it --rm ${volumes} headlessmc:latest "launch" "fabric-loader-0.14.22-1.19.4" "-commands"
```
