# frozen_string_literal: true

class Project
  include ActiveModel::Model

  attr_accessor :id, :title

  validates :title, presence: true
end
