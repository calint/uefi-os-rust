#![no_std]
#![no_main]

use log::info;
use uefi::prelude::*;

#[entry]
fn main() -> Status {
    if uefi::helpers::init().is_err() {
        return Status::ABORTED;
    }

    info!("Success! Booting with Rust 1.93 and UEFI 0.36.");

    loop {
        core::hint::spin_loop();
    }
}

#[cfg(not(test))]
#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
    loop {
        core::hint::spin_loop();
    }
}
