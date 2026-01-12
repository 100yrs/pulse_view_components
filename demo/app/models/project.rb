# frozen_string_literal: true

# Project model
class Project
  include ActiveModel::Model

  attr_accessor :id, :title

  validates :title, presence: true
end
