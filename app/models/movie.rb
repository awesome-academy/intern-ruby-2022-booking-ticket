class Movie < ApplicationRecord
  MOVIE_ATTRS = %i(title description rating image
                   duration_min release_time language
                   director cast age_range).freeze

  has_many :comments, dependent: :destroy
  has_many :show_times, dependent: :restrict_with_exception
  has_many :movie_categories, dependent: :destroy
  has_many :categories, through: :movie_categories

  accepts_nested_attributes_for :movie_categories

  has_one_attached :image

  validates :title, presence: true
  validates :release_time, presence: true
  validates :image, content_type: {in: %w(image/jpeg image/gif image/png),
                                   message: "must be a valid image format"},
                    size:         {less_than: 5.megabytes,
                                   message: "should be less than 5MB"}

  scope :sort_list, ->{order :release_time}

  def display_image
    image.variant(resize_to_limit: [1000, 600])
  end
end
