# frozen_string_literal: true

class VisitSuggestingJob < ApplicationJob
  queue_as :default

  def perform(user_ids: [], start_at: 1.week.ago, end_at: Time.current)
    users = user_ids.any? ? User.where(id: user_ids) : User.all

    users.find_each { Visits::Suggest.new(_1, start_at:, end_at:).call }
  end
end
