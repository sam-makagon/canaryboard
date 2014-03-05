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
sock.set_debug_output $stderr
sock.read_timeout = 1000
puts request.body
result = sock.start { |http| http.request(request) }
JSON.parse(result.body, symbolize_names: true)
end
 
# Getting the list of indicators and selecting the one we need
indicator = get("/indicators").select { |ind| ind[:project][:name] == "Project 2" and ind[:service][:name] == "Service 2" }.first
 
# Getting the list of possible statuses and selecting the one we need
status = get("/statuses").select { |i| i[:name] == "yellow" }.first

# Setting the status
post "/indicators/#{indicator[:id]}/events", event: {
message: "This text is supposed to explain something",
status_id: status[:id]
}
