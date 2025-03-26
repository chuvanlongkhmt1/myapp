class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    has_secure_password
    has_one_attached :avatar
    validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
    # validates :file, :image, presence: true
    # belongs_to :groupuser  
    # foreign_key: :groupuser_id
    def avatar_url
        return unless avatar.attached?
        Rails.application.routes.url_helpers.rails_blob_url(avatar, host: "http://127.0.0.1:3000")
    end
end
