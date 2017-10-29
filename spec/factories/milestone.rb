FactoryGirl.define  do
  factory :milestone do
    pos 5
    parkrunner 'Mickey Mouse'
    time '20.00'
    age_cat 'SM20-24'
    age_grade '67.96 %'
    gender 'M'
    club 'Tupelo RC'
    note 'PB stays at 00:19:25'
    total 123
    athlete_number 654321
  end

  trait :seventy_minutes
    time: '1:10:00'
  end

  trait :seventy_five_minutes
    time: '1:15:00'
  end
end