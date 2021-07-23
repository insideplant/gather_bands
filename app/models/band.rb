class Band < ApplicationRecord
  belongs_to :user
  has_many :articles, dependent: :destroy
  has_many :comments
  has_many :members

  # iine機能
  has_many :favorites, dependent: :destroy

  # follow機能
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :band

  # live開催
  has_many :live_organizations
  has_many :lives, through: :live_organizations, source: :live

  # 通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # band情報とmember情報を同時にcreate
  accepts_nested_attributes_for :members, allow_destroy: true

  validates_associated :members

  # 自身では無い時follow
  def follow(other_band)
    unless self == other_band
      relationships.find_or_create_by(follow_id: other_band.id)
    end
  end

  # followの解除
  def unfollow(other_band)
    relationship = relationships.find_by(follow_id: other_band.id)
    relationship.destroy if relationship
  end

  # followしているユーザーを取得
  def following?(other_band)
    followings.include?(other_band)
  end

  # followに関する通知を作成
  def create_notification_follow!(current_band)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_band.id, id, 'follow'])
    if temp.blank?
      notification = current_band.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def member_name_role
    member_array = members.map { |member| member.name + "(#{member.role})" }
    member_array.join(" , ")
  end
end
