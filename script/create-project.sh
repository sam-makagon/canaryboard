echo creating project $1
curl -X POST -H "Content-Type: application/json" -H 'Authorization: Token token="d44a5117888b7fdd66409314944f4489"' -d "{ \"project\": { \"name\": \"$1\" } }" http://localhost:3000/api/projects
echo

