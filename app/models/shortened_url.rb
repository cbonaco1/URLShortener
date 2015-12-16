class ShortenedUrl < ActiveRecord::Base

  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true, uniqueness: true

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  def self.random_code
    rand_code =  SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(rand_code)
      rand_code =  SecureRandom.urlsafe_base64
    end

    rand_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      short_url: self.random_code,
      long_url: long_url,
      submitter_id: user.id
    )
  end



end
