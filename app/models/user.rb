class User < ActiveRecord::Base
  #validations in model
  validates :email, uniqueness: true, presence: true

  # s.submitted_urls returns all the URLs Scott submitted
  # by matching the URLs' submitted_ids
  has_many(
    :submitted_urls,
    :class_name => "ShortenedUrl",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )
end
