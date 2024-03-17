FactoryBot.define do
  factory :student do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    surname {Faker::Name.suffix}
    sequence(:id) {|n| "#{n}"}
    school_id {|a| "#{a}"}
    sequence(:email) {|i| "email#{i}@email.com"}
    password {"password"}
  end
end