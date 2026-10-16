# Lindle image
#
# The ctx stage holds build scripts and files so they are available while
# building without being copied into the final image.
FROM scratch AS ctx
COPY build_files /
COPY system_files /system_files

# NVIDIA drivers, prebuilt by Universal Blue for the base image's kernel.
# Only used by the lindle-nvidia edition (NVIDIA=Y).
FROM ghcr.io/ublue-os/akmods-nvidia-open:main-44 AS akmods_nvidia

# Base: Universal Blue's Fedora KDE (Kinoite) image, which already ships
# codecs, Flathub and hardware enablement. Renovate keeps the digest current.
FROM ghcr.io/ublue-os/kinoite-main:44
ARG NVIDIA=N

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=bind,from=akmods_nvidia,src=/rpms,dst=/tmp/akmods-nv-rpms \
    NVIDIA="${NVIDIA}" /ctx/build.sh

RUN bootc container lint
