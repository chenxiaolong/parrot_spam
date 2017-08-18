use std::env;
use std::process;

const MAX_CHARS: usize = 4000;

fn main() {
    let mut used = 0usize;

    let args: Vec<String> = env::args()
        .skip(1)
        .filter(|x| !x.is_empty())
        .collect();

    if args.is_empty() {
        eprintln!("Nothing to repeat");
        process::exit(1);
    }

    for arg in args.iter().cycle().take_while(|&x| {
        used += x.len();
        used <= MAX_CHARS
    }) {
        print!("{}", arg);
    }
}
