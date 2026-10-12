# Lindle image
#
# The ctx stage holds build scripts and files so they are available while
# building without being copied into the final image.
FROM scratch AS ctx
COPY build_files /
COPY system_files /system_files

# Base: Universal Blue's Fedora KDE (Kinoite) image, which already ships
# codecs, Flathub and hardware enablement. Renovate keeps the digest current.
FROM ghcr.io/ublue-os/kinoite-main:44

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

RUN bootc container lint
