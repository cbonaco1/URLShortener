class ShortenedUrl < ActiveRecord::Base

  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :short_url_id,
    :primary_key => :id
  )

  #Visitors for a short url
  has_many(
    :visitors,
    through: :visits,
    source: :user
  )

  has_many(
    :num_uniques,
    Proc.new { distinct },
    through: :visits,
    source: :user
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

  def num_clicks
    visitors.count
  end

  # def num_uniques
  #   visitors.select("user_id").distinct.count
  # end

  def num_uniq_recent_clicks
    visitors.select("visits.user_id").where("visits.created_at > ?", 10.minutes.ago ).distinct.count
    # This works, too, but only because in all the joins we make, "user_id" is unique:
    # visitors.select("user_id").where("visits.created_at > ?", 10.minutes.ago ).distinct.count
  end

end
