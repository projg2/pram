FROM alpine
WORKDIR /pram/build
COPY . /pram
RUN ["apk", "add", "bash", "diffutils", "git", "meson", "ninja"]
RUN ["meson", ".."]
RUN ["ninja"]
CMD ["ninja", "test"]
