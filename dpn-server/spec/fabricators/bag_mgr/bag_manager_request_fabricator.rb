Fabricator(:bag_manager_request) do
  source_location { Faker::Internet.url }
  preservation_location nil
  status :requested
  fixity nil
  validity nil
  cancelled false
end