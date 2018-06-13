require_relative ."/lib/tcdocs"


class Documentary

  attr_accessor :title, :year, :category :synopsis, :synopsis_url

  @@all = []

  def initialize(hash)
    documentary_hash.each do |k,v|
      self.send("#{k}=", v)
    end
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def find_or_create_by_category(category)
    find_by_category(category) || Category.create(category)
  end

  def find_by_category(category)
    Category.all.detect {|c| c.name == category}
  end

  def category=(category)
    @category = find_or_create_by_category(category)
    @category.documentaries << self unless @category.documentaries.include?(self)
  end
end
