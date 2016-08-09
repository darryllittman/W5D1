FactoryGirl.define do
  factory :goal do
    title 'a_public_goal'
    description 'blah'
    private 'public'
    user_id 1
    status "uncompleted"
  end
end
