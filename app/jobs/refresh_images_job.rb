class RefreshImagesJob < ApplicationJob
  queue_as :default

  def perform
    Image.destroy_all
  end
end
