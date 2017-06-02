FactoryGirl.define do

  factory :publication do
    title {Faker::Job.title}
    description {Faker::Lorem.paragraph(2)}
    customer {Faker::Company.name}
  end

  factory :bill do
    publication
    amount 154.35
  end

end
