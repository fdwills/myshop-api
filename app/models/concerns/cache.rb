module Cache
  extend ActiveSupport::Concern

  included do
    def self.get_or_cache(id)
      unless instance = Rails.cache.read("#{self.name}_#{id}")
        instance = self.find_by_id(id)
        Rails.cache.write("#{self.name}_#{id}", instance)
      end
      instance
    end
  end

  def clear_cache
    Rails.cache.delete("#{self.class.name}_#{self.id}")
  end

  def recache
    Rails.cache.delete("#{self.class.name}_#{self.id}")
    instance = self.class.find_by_id(id)
    Rails.cache.write("#{self.class.name}_#{self.id}", instance) if instance
  end
end
