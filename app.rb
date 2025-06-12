require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader' if development?

# In-memory store
USERS = []

# Home
get '/' do
  "Welcome to Ruby CRUD app!"
end

# List users
get '/users' do
  json USERS
end

# Create user
post '/users' do
  data = JSON.parse(request.body.read)
  user = {
    id: USERS.size + 1,
    name: data["name"],
    email: data["email"]
  }
  USERS << user
  json user
end

# Read user
get '/users/:id' do
  user = USERS.find { |u| u[:id] == params[:id].to_i }
  if user
    json user
  else
    halt 404, json(message: "User not found")
  end
end

# Update user
put '/users/:id' do
  data = JSON.parse(request.body.read)
  user = USERS.find { |u| u[:id] == params[:id].to_i }
  if user
    user[:name] = data["name"] if data["name"]
    user[:email] = data["email"] if data["email"]
    json user
  else
    halt 404, json(message: "User not found")
  end
end

# Delete user
delete '/users/:id' do
  index = USERS.index { |u| u[:id] == params[:id].to_i }
  if index
    USERS.delete_at(index)
    json message: "User deleted"
  else
    halt 404, json(message: "User not found")
  end
end
