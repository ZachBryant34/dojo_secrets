FactoryBot.define do
  factory :secret do
    content { "secret 1" }
    user { nil }
  end
end
