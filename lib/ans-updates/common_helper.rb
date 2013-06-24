module Ans::Updates::CommonHelper
  def config
    Ans::Updates.config
  end

  def updates_path
    Rails.root.join config.path
  end
end
