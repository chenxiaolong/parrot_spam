use actix_web::{
    body::Body,
    dev::ServiceResponse,
    http::{header, StatusCode},
    test,
    App,
};
use actix_service::Service;

fn get_body_str(resp: &ServiceResponse) -> &str {
    match resp.response().body().as_ref() {
        Some(Body::Bytes(bytes)) => std::str::from_utf8(&bytes).unwrap(),
        _ => panic!("Invalid response"),
    }
}

#[actix_rt::test]
async fn good_request() {
    let mut app = test::init_service(
        App::new().configure(super::config_app)).await;

    let req = test::TestRequest::post()
        .uri("/")
        .header(header::CONTENT_TYPE, "application/json")
        .set_payload(r#"[":rbs:", ":p:"]"#.as_bytes())
        .to_request();

    let resp = app.call(req).await.unwrap();

    assert_eq!(resp.status(), StatusCode::OK);
    assert_eq!(get_body_str(&resp), ":rbs::p:".repeat(500));
}

#[actix_rt::test]
async fn no_terms() {
    let mut app = test::init_service(
        App::new().configure(super::config_app)).await;

    let req = test::TestRequest::post()
        .uri("/")
        .header(header::CONTENT_TYPE, "application/json")
        .set_payload(r#"[]"#.as_bytes())
        .to_request();

    let resp = app.call(req).await.unwrap();

    assert_eq!(resp.status(), StatusCode::UNPROCESSABLE_ENTITY);
    assert_eq!(get_body_str(&resp), "Nothing to repeat");
}

#[actix_rt::test]
async fn invalid_json() {
    let mut app = test::init_service(
        App::new().configure(super::config_app)).await;

    let req = test::TestRequest::post()
        .uri("/")
        .header(header::CONTENT_TYPE, "application/json")
        .set_payload(r#"[1, 2]"#.as_bytes())
        .to_request();

    let resp = app.call(req).await.unwrap();

    assert_eq!(resp.status(), StatusCode::BAD_REQUEST);
}

#[actix_rt::test]
async fn malformed_json() {
    let mut app = test::init_service(
        App::new().configure(super::config_app)).await;

    let req = test::TestRequest::post()
        .uri("/")
        .header(header::CONTENT_TYPE, "application/json")
        .set_payload(r#"!@#$%^&*()"#.as_bytes())
        .to_request();

    let resp = app.call(req).await.unwrap();

    assert_eq!(resp.status(), StatusCode::BAD_REQUEST);
}
