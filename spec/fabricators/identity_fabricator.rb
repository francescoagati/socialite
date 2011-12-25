Fabricator :identity, class_name: Identity do
  unique_id { sequence(:unique_id, 1000) { |n| "abcdef#{n}" } }
  provider 'facebook'
  auth_hash { x = { 'credentials' => {'token' => '123648493','secret' => '12477388272'} } }
  api fabricator: :facebook_identity
end
