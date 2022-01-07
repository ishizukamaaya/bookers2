class User < ApplicationRecord
  # attachment :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォロー中を取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #フォローを取得
  has_many :following_user, through: :follower, source: :followed #フォロー中
  has_many :follower_user, through: :followed, source: :follower #フォローワー

  has_many :favorites, dependent: :destroy

  #フォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  #フォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  #フォローしているか確認
  def following?(user)
    following_user.include?(user)
  end

end
