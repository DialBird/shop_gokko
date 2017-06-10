# == Schema Information
#
# Table name: carts # カート
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  status_id  :integer          default("1"), not null # ステータスID
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cart < ApplicationRecord
  belongs_to :user
end
