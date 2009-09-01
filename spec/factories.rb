Factory.sequence :login do |n|
  "user#{n}"
end

Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |u|
  u.email { Factory.next(:email) }
  u.login { Factory.next(:login) }
  u.password 'test'
  u.password_confirmation 'test'
end

Factory.define :project do |p|
  p.association :user
end
