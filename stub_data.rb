#!/usr/bin/env ruby
require 'byebug'
require "uri"
require "net/https"
require "time"
require "rubygems"
require "api-auth"
require 'active_record'

def create(url, body)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
  request.body = body.to_json
  response = http.request(request)
  puts response.body
end

# create("http://localhost:4000/organizations/", {
#   organization: {
#     name: 'Local',
#     key: 'key',
#     secret: 'secret',
#     settings: {
#       base_url: 'http://localhost:3000',
#       api_token: 'KmrdM0oD20ANCuqKgnd4quHrqoDGuXy84vTNjHHRfHxxs6NAckrltq4Y40CwUJ8a'
#     }
#   }
# })

# create("http://localhost:4000/organizations/1/users", {
#   user: {
#     canvas_user_id: "4",
#     sis_id: "user_4",
#     data: {
#       first_name: 'Stan',
#       last_name: 'Derson',
#       email: 'stan@test.com',
#       phone: '801-444-4444',
#       address: '123 Elm St.'
#     }
#   }
# })

create("http://localhost:4000/organizations/1/tables", {
  table: {
    user_id: 1,
    course_id: 1,
    name: 'Table 2'
  }
})

create("http://localhost:4000/organizations/1/tables/1/table_rows", {
  table_row: {
    table_id: 2,
    data: {
      "name" => "Joe",
      "age" => "31",
      "gender" => "male"
    }
  }
})

create("http://localhost:4000/organizations/1/tables/1/table_columns", {
  table_column: {
    table_id: 2,
    name: "name",
    position: 0
  }
})

create("http://localhost:4000/organizations/1/tables/1/table_columns", {
  table_column: {
    table_id: 2,
    name: "age",
    position: 1
  }
})

create("http://localhost:4000/organizations/1/tables/1/table_columns", {
  table_column: {
    table_id: 2,
    name: "gender",
    position: 2
  }
})

