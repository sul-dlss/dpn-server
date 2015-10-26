# Copyright (c) 2015 The Regents of the University of Michigan.
# All Rights Reserved.
# Licensed according to the terms of the Revised BSD License
# See LICENSE.md for details.


require 'securerandom'

Fabricator(:node) do
  namespace do
    sequence(:namespace, 50) do |i|
      "namespace_#{i}"
    end
  end

  name { Faker::Company.name }
  ssh_pubkey { Faker::Internet.password(20) }
  storage_region
  storage_type
  private_auth_token { Faker::Code.isbn }
  api_root { Faker::Internet.url }
  auth_credential { Faker::Code.isbn }
  created_at 1.second.ago
  updated_at 1.second.ago
end

Fabricator(:local_node, class_name: :node) do
  namespace { Rails.configuration.local_namespace }
  name { Faker::Company.name }
  ssh_pubkey { Faker::Internet.password(20) }
  storage_region
  storage_type
  api_root { Faker::Internet.url }
  auth_credential { Faker::Code.isbn }
  private_auth_token { |attrs| "#{attrs[:auth_credential]}" }
  created_at 1.hour.ago
  updated_at 1.hour.ago
end