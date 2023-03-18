FactoryBot.define do
  factory :test_label, class: Label do
    label_name { "ラベル１" }
  end

  factory :test_label2,class: Label do
    label_name { "sample2" }
  end
end
