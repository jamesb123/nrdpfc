module ActiveRecordSecurityHelpers
  def authorize_all_for_crud
    %w[create read update destroy].each{|crud|
      define_method("authorized_for_#{crud}?") do
        true
      end
    }
  end
end

ActiveRecord::Base.send :extend, ActiveRecordSecurityHelpers
