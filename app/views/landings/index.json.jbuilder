json.array!(@landings) do |landing|
  json.extract! landing, :id, :email
  json.url landing(landing, format: :json)
end
