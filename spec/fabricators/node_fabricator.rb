Fabricator(:node) do
  namespace do
    sequence(:namespace) do |i|
      "namespace_#{i}"
    end
  end

  name { Faker::Company.name }
  ssh_pubkey { Faker::Internet.password(20) }
  storage_region
  storage_type


end