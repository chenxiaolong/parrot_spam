use warp::http::StatusCode;
use warp::test::request;

#[tokio::test]
async fn good_request() {
    let resp = request()
        .method("POST")
        .path("/")
        .json(&[":rbs:", ":p:"])
        .reply(&super::spam())
        .await;

    assert_eq!(resp.status(), StatusCode::OK);
    assert_eq!(resp.body(), &":rbs::p:".repeat(500));
}

#[tokio::test]
async fn no_terms() {
    let resp = request()
        .method("POST")
        .path("/")
        .json(&([] as [String; 0]))
        .reply(&super::spam())
        .await;

    assert_eq!(resp.status(), StatusCode::UNPROCESSABLE_ENTITY);
    assert_eq!(resp.body(), &"Nothing to repeat");
}

#[tokio::test]
async fn invalid_json() {
    let resp = request()
        .method("POST")
        .path("/")
        .json(&[1, 2])
        .reply(&super::spam())
        .await;

    assert_eq!(resp.status(), StatusCode::BAD_REQUEST);
}

#[tokio::test]
async fn malformed_json() {
    let resp = request()
        .method("POST")
        .path("/")
        .header("Content-Type", "application/json")
        .body(r#"!@#$%^&*()"#)
        .reply(&super::spam())
        .await;

    assert_eq!(resp.status(), StatusCode::BAD_REQUEST);
}
