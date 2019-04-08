use super::app;
use rocket::local::Client;
use rocket::http::{Status, ContentType};

#[test]
fn bad_spam() {
    let client = Client::new(app()).unwrap();

    // Normal request
    let mut res = client
        .post("/")
        .header(ContentType::JSON)
        .body(r#"[":rbs:", ":p:"]"#)
        .dispatch();
    assert_eq!(res.status(), Status::Ok);
    assert_eq!(res.body_string().unwrap(), ":rbs::p:".repeat(500));

    // No terms provided
    let mut res = client
        .post("/")
        .header(ContentType::JSON)
        .body(r#"[]"#)
        .dispatch();
    assert_eq!(res.status(), Status::UnprocessableEntity);
    assert_eq!(res.body_string().unwrap(), "Nothing to repeat");

    // Invalid JSON data
    let res = client
        .post("/")
        .header(ContentType::JSON)
        .body(r#"{"foo": "bar"}"#)
        .dispatch();
    assert_eq!(res.status(), Status::UnprocessableEntity);

    // Malformed JSON
    let res = client
        .post("/")
        .header(ContentType::JSON)
        .body(r#"!@#$%^&*()"#)
        .dispatch();
    assert_eq!(res.status(), Status::BadRequest);
}
