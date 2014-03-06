#time=`date`;
start_time="March 06 2014 8:32AM"
stop_time="March 06 2014 11:32AM"
curl -X POST -H "Content-Type: application/json" -H 'Authorization: Token token="d44a5117888b7fdd66409314944f4489"' -d "{\"event\":{\"message\":\"Error connecting to database TREPPSQL!\",\"status_id\":3,\"started_at\":\"$start_time\",\"stopped_at\":\"$stop_time\"}}" 10.0.2.15:3000/api/indicators/26/events

