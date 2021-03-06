class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_many :bucketlists, dependent: :destroy
  before_create :add_unique_token
  before_save :refresh_token
  enum login_status: [:logged_out, :logged_in]
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX }
  has_secure_password

  private
    def refresh_token
      add_unique_token if login_status_changed? && self.logged_in?
    end

    def add_unique_token
      begin
        token = generate_token
        self.token = token
      end while User.find_by_token(token)
    end

    def generate_token
      SecureRandom.uuid.gsub(/\-/, '')
    end
end
