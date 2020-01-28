#![allow(non_snake_case)]

use std::env;

use actix_web::{
    http::StatusCode,
    middleware::Logger,
    web::{self, Json, JsonConfig},
    App,
    HttpResponse,
    HttpServer,
};

const MAX_CHARS: usize = 4000;

async fn spam(mut terms: Json<Vec<String>>) -> HttpResponse {
    terms.retain(|x| !x.is_empty());

    if terms.is_empty() {
        return HttpResponse::build(StatusCode::UNPROCESSABLE_ENTITY)
            .body("Nothing to repeat");
    }

    let mut used = 0;

    let result = terms
        .iter()
        .cycle()
        .take_while(|&x| {
            used += x.len();
            used <= MAX_CHARS
        })
        .map(|x| { x.as_str() })
        .collect::<String>();

    HttpResponse::Ok().body(result)
}

fn config_app(cfg: &mut web::ServiceConfig) {
    cfg.data(JsonConfig::default().limit(2 * MAX_CHARS))
        .service(web::resource("/").route(web::post().to(spam)));
}

#[actix_rt::main]
async fn main() -> std::io::Result<()> {
    if env::var_os("RUST_LOG").is_none() {
        // Set `RUST_LOG=debug` to see debug logs
        env::set_var("RUST_LOG", "info");
    }
    pretty_env_logger::init();

    HttpServer::new(|| {
        App::new()
            .wrap(Logger::default())
            .configure(config_app)
    })
        .bind("0.0.0.0:8080")?
        .run()
        .await
}

// Tests are in tests.rs
#[cfg(test)]
mod tests;
