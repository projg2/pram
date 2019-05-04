FROM archlinux/base
WORKDIR /pram/build
COPY . /pram
RUN ["pacman", "--noconfirm", "-Sy", "cmake", "diffutils", "git", "ninja"]
RUN ["cmake", "..", "-G", "Ninja"]
RUN ["ctest", "-j", "$(nproc)"]
CMD ["bash", "/pram/pram"]
