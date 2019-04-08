#![allow(non_snake_case)]
#![feature(proc_macro_hygiene, decl_macro)]

use rocket::{self,post,routes,Rocket};
use rocket::response::status::BadRequest;
use rocket_contrib::json::Json;

const MAX_CHARS: usize = 4000;

// Intentionally omitting 'format = "json"' so that Content-Type is ignored
#[post("/", data = "<terms>")]
fn spam(mut terms: Json<Vec<String>>) -> Result<String, BadRequest<&'static str>> {
    terms.retain(|x| !x.is_empty());

    if terms.is_empty() {
        return Err(BadRequest(Some("Nothing to repeat")));
    }

    let mut used = 0usize;

    let result = terms
        .iter()
        .cycle()
        .take_while(|&x| {
            used += x.len();
            used <= MAX_CHARS
        })
        .map(|x| { x.as_str() })
        .collect::<String>();

    Ok(result)
}

fn app() -> Rocket {
    rocket::ignite().mount("/", routes![spam])
}

fn main() {
    app().launch();
}

// Tests are in tests.rs
#[cfg(test)]
mod tests;
