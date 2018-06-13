class TCDocs::TCDocsController

  attr_accessor :categories

  def call
    puts "Welcome to True Crime Documentary Database!"
    input = nil
    while input != 'exit'
      puts "Enter number '1' to browse by documentaries by category or '2' to see all documentaries."
      puts "Enter 'exit' to quit."
      input = gets.strip
      case input
      when "1" then show_categories_menu
      when "2" then list_all_documentaries
    end
  end

  def list_all_documentaries
    Category.all.each_with_index do |doc, num|
      puts "#{num}." + " #{doc.title.upcase}.colorize(:blue)"
      puts "  Year:".colorize(:light_blue) +  "#{doc.year}"
      puts "  Category:".colorize(:light_blue) + " #{doc.category.name}"
      puts "\n"
      puts "  Synopsis:".colorize(:light_blue)
      puts " #{word_wrap(doc.synopsis)}"
      puts "  Full synopsis URL:".colorize(:light_blue) + " #{doc.synopsis_url}"
    end
  end

  def list_all_categories
    puts "True Crime Categories"
    Category.all.sort_by {|doc| doc.title}.each_with_index(1) do |doc, num|
      puts "#{num}. #{doc.name}"
      categories << doc.name
    end
  end

  def show_categories_menu
    puts "Enter nunber for category."
    puts "Enter 'return' for main menu, or 'exit' to quit."
    input = nil
    while input != 'exit'
      list_all_categories
      input = gets.strip
      case input
      when input.size == 1 && input.to_i
        list_documentaries_by_category(categories[input.to_i-1])
      when "Return".downcase
        call
      end
    end
  end

  def list_documentaries_by_category(category)
    docs_by_cat = Category.all.detect {|c| c.downcase == category.downcase}
    docs_by_cat.each_with_index(1) do |doc, num|
      puts "#{num}." + " #{doc.title.upcase}.colorize(:blue)"
      puts "  Year:".colorize(:light_blue) +  "#{doc.year}"
      puts "  Category:".colorize(:light_blue) + " #{doc.category.name}"
      puts "\n"
      puts "  Synopsis:".colorize(:light_blue)
      puts " #{word_wrap(doc.synopsis)}"
      puts "  Full synopsis URL:".colorize(:light_blue) + " #{doc.synopsis_url}"
    end
  end

  def categories
    @categories = []
  end

  # Not my code.
  # Source: https://www.safaribooksonline.com/library/view/ruby-cookbook/0596523696/ch01s15.html
  def word_wrap(text, width=78)
    lines = []
	  line = ""
	  s.split(/\s+/).each do |word|
	    if line.size + word.size >= width
	      lines << line
	      line = word
	    elsif line.empty?
	     line = word
	    else
	     line << " " << word
	   end
	   end
	   lines << line if line
	  return lines.join "\n"
  end
end
