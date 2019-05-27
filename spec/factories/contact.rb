FactoryBot.define do
  factory :contact do
    contact_title { "contact_title_test" }
    contact_text { "contact_text_test" }
    contact_email { "contact_email_test" }
    user_id { 2 }
    contact_name { "contact_name_test" }
  end

  factory :un_sign_in_contact, class: Contact do
    contact_title { "contact_title_test" }
    contact_text { "contact_text_test" }
    contact_email { "contact_email_test" }
    contact_name { "contact_name_test" }
  end
end
