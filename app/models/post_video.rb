class PostVideo < ActiveRecord::Base
  belongs_to :post, inverse_of: :post_videos

  validates :url, presence: true
  validates :title, allow_blank: true, length: { minimum: 2, maximum: 50 }
  validates :post, presence: true

  def set_url
    self.url
  end

  def set_url=(url)
    self.url = YouTubeAddy.extract_video_id(url)
  end
end
