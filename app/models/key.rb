class Key < ActiveRecord::Base
  before_create :generate_key
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false }

private

  def generate_key
    self.key = SecureRandom.urlsafe_base64(10)
  end

end