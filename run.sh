#!/bin/bash
# 1. Compile the code
cargo build

# 2. Create the standard hardware directory path
mkdir -p build/EFI/BOOT

# 3. Copy and rename the binary to the hardware default name
cp target/x86_64-unknown-uefi/debug/uefi-os-rust.efi build/EFI/BOOT/BOOTX64.EFI

qemu-system-x86_64 -enable-kvm -cpu host -m 16G -vga std -serial stdio \
    -smp 4,sockets=1,cores=2,threads=2 \
    -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/x64/OVMF_CODE.4m.fd \
    -drive format=raw,file=fat:rw:build # -full-screen
