FactoryGirl.define do
  factory :user do
    name                             "Bob"
    email                             "Bob@gmail.com"
    password                       "foobar"
    password_confirmation  "foobar"
  end
end