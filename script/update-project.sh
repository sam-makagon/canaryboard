time=`date`;
curl -X POST -H "Content-Type: application/json" -H 'Authorization: Token token="d44a5117888b7fdd66409314944f4489"' -d "{\"event\":{\"message\":\"Error connecting to database TREPPSQL!\",\"status_id\":3}}" 10.0.2.15:3000/api/indicators/26/events

