class Task < ApplicationRecord
  #content,titleが空っぽでないか。255字を超えてないか
  validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 10 }
end
