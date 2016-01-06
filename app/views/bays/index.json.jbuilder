json.array!(@bays) do |bay|
  json.extract! bay, :id, :code, :position
  json.url bay_url(bay, format: :json)
end
