#!/usr/bin/env ruby
require 'net/http'
require 'json'
require 'securerandom'

API_URL = URI.parse("http://localhost:3000/api")
API_KEY = "d44a5117888b7fdd66409314944f4489"

def get url
  request = Net::HTTP::Get.new(API_URL.path + url)
  request["Content-Type"] = "application/json"
  sock = Net::HTTP.new(API_URL.host, API_URL.port)
  sock.read_timeout = 1000
  result = sock.start { |http| http.request(request) }
  JSON.parse(result.body, symbolize_names: true)
end

def post url, body = {}
  request = Net::HTTP::Post.new(API_URL.path + url)
  request.body = body.to_json
  request["Content-Type"] = "application/json"
  request["Authorization"] = "Token token=\"#{API_KEY}\""
  sock = Net::HTTP.new(API_URL.host, API_URL.port)
  sock.read_timeout = 1000
  result = sock.start { |http| http.request(request) }
  JSON.parse(result.body, symbolize_names: true)
end

def put url, body = {}
  request = Net::HTTP::Put.new(API_URL.path + url)
  request.body = body.to_json
  request["Content-Type"] = "application/json"
  request["Authorization"] = "Token token=\"#{API_KEY}\""
  sock = Net::HTTP.new(API_URL.host, API_URL.port)
  sock.read_timeout = 1000
  result = sock.start { |http| http.request(request) }
  JSON.parse(result.body, symbolize_names: true)
end

def delete url
  request = Net::HTTP::Delete.new(API_URL.path + url)
  request["Content-Type"] = "application/json"
  request["Authorization"] = "Token token=\"#{API_KEY}\""
  sock = Net::HTTP.new(API_URL.host, API_URL.port)
  sock.read_timeout = 1000
  result = sock.start { |http| http.request(request) }
  JSON.parse(result.body, symbolize_names: true)
end

raise(StandardError, "Set the API_KEY") if API_KEY == "set_me"

puts "\tAPI server status"
puts server = get("") rescue raise(StandardError, "API doesn't respond, change API_URL (currently #{API_URL})")

puts "\tListing projects"
puts get "/projects"

puts "\tListing services"
puts get "/services"

puts "\tCreating new project (returns created project)"
puts project = post("/projects", { project: { name: SecureRandom.hex } })

puts "\tUpdating this project (returns updated project)"
puts put "/projects/#{project[:id]}", { project: { name: SecureRandom.hex } }

puts "\tCreating new service (returns created service)"
puts service = post("/services", { service: { name: SecureRandom.hex } })

puts "\tUpdating this service (returns updated service)"
puts put "/services/#{service[:id]}", { service: { name: SecureRandom.hex } }

puts "\tListing indicators"
puts indicators = get("/indicators")

puts "\tListing available statuses"
puts statuses = get("/statuses")

puts "\tCreating new event for indicator aka Updating indicator's status (returns created event)"
# Finding indicator for new service
indicator = indicators.select { |i| i[:project][:id] == project[:id] and i[:service][:id] == service[:id] }.first
# Finding status to set
status = statuses.select { |i| i[:name] == "red" }.first
puts post "/indicators/#{indicator[:id]}/events", event: {
  message: "sorry guys system went down",
  status_id: status[:id]
}

puts "\tSetting status back to green"
status = statuses.select { |i| i[:name] == "green" }.first
puts post "/indicators/#{indicator[:id]}/events", event: {
  message: "back to normal",
  status_id: status[:id]
}

puts "\tListing indicator's history"
puts get "/indicators/#{indicator[:id]}/events"

puts "\tDeleting project (returns deleted project)"
puts delete "/projects/#{project[:id]}"

puts "\tDeleting service (returns deleted service)"
puts delete "/services/#{service[:id]}"
