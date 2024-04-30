cat >talos.yml <<'EOF'
arch: amd64
platform: nocloud
secureboot: false
version: v1.6.7
customization:
  extraKernelArgs:
    - net.ifnames=0
input:
  kernel:
    path: /usr/install/amd64/vmlinuz
  initramfs:
    path: /usr/install/amd64/initramfs.xz
  baseInstaller:
    imageRef: ghcr.io/siderolabs/installer:v1.6.7
  systemExtensions:
    - imageRef: ghcr.io/siderolabs/qemu-guest-agent:8.2.2
output:
  kind: image
  imageOptions:
    diskSize: 2147483648
    diskFormat: raw
  outFormat: raw
EOF

mkdir -p tmp/talos
docker run --rm -i \
    -v /home/homelab//tmp/talos:/secureboot:ro \
    -v /home/homelab//tmp/talos:/out \
    -v /dev:/dev \
    --privileged \
    ghcr.io/siderolabs/imager:v1.6.7 \
    - <talos.yml

qemu-img convert -O qcow2 /home/homelab/tmp/talos/nocloud-amd64.raw tmp/talos/nocloud-amd64.qcow2