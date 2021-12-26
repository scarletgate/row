class Inquiry < ApplicationRecord
  enum subject: { inquiries_about_users: 0, inquiries_about_posting: 1, other_inquiries: 2 }
  validates :name, presence: true
  validates :email, presence: true
  validates :subject, presence: true
  validates :message, presence: true
end
