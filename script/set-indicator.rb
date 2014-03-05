#!/usr/bin/env ruby
require 'net/http'
require 'json'
 
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
 
puts "\tListing projects"
puts get "/projects"
 
puts "\tListing services"
puts get "/services"
 
 
puts "\tCreating new project (returns created project)"
puts project = post("/projects", { project: { name: "Project 1" } })
raise StandardError unless project[:id]
 
puts "\tCreating new service (returns created service)"
puts service = post("/services", { service: { name: "Service 1" } })
 
puts "\tCreating new project (returns created project)"
puts project = post("/projects", { project: { name: "Project 2" } })
raise StandardError unless project[:id]
 
puts "\tCreating new service (returns created service)"
puts service = post("/services", { service: { name: "Service 2" } })
 
puts "\tCreating new project (returns created project)"
puts project = post("/projects", { project: { name: "Project 3" } })
raise StandardError unless project[:id]
 
puts "\tCreating new service (returns created service)"
puts service = post("/services", { service: { name: "Service 3" } })
 
puts "\tCreating new project (returns created project)"
puts project = post("/projects", { project: { name: "Project 4" } })
raise StandardError unless project[:id]
 
puts "\tCreating new service (returns created service)"
puts service = post("/services", { service: { name: "Service 4" } })
 
 
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
 
puts "\tListing indicator's history"
puts get "/indicators/#{indicator[:id]}/events"
