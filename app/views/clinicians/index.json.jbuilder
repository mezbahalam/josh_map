json.array!(@clinicians) do |clinician|
  json.extract! clinician, :id, :address, :latitude, :longitude
  json.url clinician_url(clinician, format: :json)
end
