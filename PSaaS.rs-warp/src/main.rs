#![allow(non_snake_case)]

use std::env;

use warp::{
    http::StatusCode,
    Filter,
    reject::Reject,
    Rejection,
    Reply,
};

const MAX_CHARS: usize = 4000;

#[derive(Debug)]
struct NothingToRepeat;

impl Reject for NothingToRepeat {}

#[tokio::main]
async fn main() {
    if env::var_os("RUST_LOG").is_none() {
        // Set `RUST_LOG=psaas=debug` to see debug logs
        env::set_var("RUST_LOG", "psaas=info");
    }
    pretty_env_logger::init();

    let endpoint = spam()
        .with(warp::log("psaas"));

    warp::serve(endpoint)
        .run(([0, 0, 0, 0], 3030))
        .await;
}

fn spam() -> impl Filter<Extract = impl Reply, Error = Rejection> + Clone {
    warp::post()
        .and(warp::path::end())
        .and(warp::body::content_length_limit(2 * MAX_CHARS as u64))
        .and(warp::body::json())
        .and_then(|mut terms: Vec<String>| {
            async move {
                terms.retain(|x| !x.is_empty());

                if terms.is_empty() {
                    return Err(warp::reject::custom(NothingToRepeat));
                }

                let mut used = 0;

                Ok(terms
                    .iter()
                    .cycle()
                    .take_while(|&x| {
                        used += x.len();
                        used <= MAX_CHARS
                    })
                    .map(|x| { x.as_str() })
                    .collect::<String>())
            }
        })
        .recover(handle_rejection)
}

async fn handle_rejection(err: Rejection) -> Result<impl Reply, Rejection> {
    if let Some(_) = err.find::<NothingToRepeat>() {
        Ok(warp::reply::with_status("Nothing to repeat",
                StatusCode::UNPROCESSABLE_ENTITY))
    } else {
        // Use default error handler
        Err(err)
    }
}

// Tests are in tests.rs
#[cfg(test)]
mod tests;
