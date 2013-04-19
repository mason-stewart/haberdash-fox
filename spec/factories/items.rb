# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    title "Cool Used Jacket"
    description "So hipster, it hurts. Cowabunga, dudes!"
    price 1
    # url "http://www.etsy.com/listing/44652014/mothers-day-card-you-are-braver-than-you"
    # etsy_id "44652014"
  end
end
