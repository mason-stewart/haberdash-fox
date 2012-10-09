# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    title "MyString"
    description "MyText"
    photo "MyString"
    price 1
    url "MyString"
  end
end
