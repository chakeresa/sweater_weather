require 'rails_helper'

describe RefreshImagesJob, type: :job do
  it 'destroys all image resources' do
    create_list(:image, 2)
    
    expect(Image.count).to eq(2)

    RefreshImagesJob.perform_now

    expect(Image.count).to eq(0)
  end
end
