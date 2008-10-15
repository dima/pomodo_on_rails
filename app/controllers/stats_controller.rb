class StatsController < ApplicationController
  def summary
    render :xml => Stats.new
  end
end