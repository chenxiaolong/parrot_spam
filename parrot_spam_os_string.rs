use std::env;
use std::ffi;
use std::io::{self, Write};
use std::process;

use std::os::unix::ffi::OsStrExt;

const MAX_CHARS: usize = 4000;

fn main() {
    let mut used = 0usize;

    let args: Vec<ffi::OsString> = env::args_os()
        .skip(1)
        .filter(|x| !x.is_empty())
        .collect();
    let stdout = io::stdout();
    let mut handle = stdout.lock();

    if args.is_empty() {
        eprintln!("Nothing to repeat");
        process::exit(1);
    }

    for arg in args.iter().cycle().take_while(|&x| {
        used += x.len();
        used <= MAX_CHARS
    }) {
        handle.write(arg.as_os_str().as_bytes())
            .expect("Failed to write to stdout");
    }
}
