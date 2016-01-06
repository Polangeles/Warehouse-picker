class SearchController < ApplicationController

  def search
    @bays = []
    @products = []
    @distance = nil
    @by_bay = ""
    @by_name = ""

    return if !params.include?("search")
    # Consider bay codes if provided

    @by_bay = params["search"]["by_bay"].downcase
    # By default we start with no product names
    if @by_bay != ""
      # Keep only the letters a, b, c, or d, numbers, and commas
      # Otherwise we risk SQL injection attacks :(
      @by_bay.gsub!(/[^abcd0123456789,]/, "")
      # Turn it into something like: 'b5', 'b10', 'b6'
      bay_list = "'" + @by_bay.split(",").join("', '") + "'"
      @products = Product.find_by_sql("SELECT p.id, p.name, b.code AS bay_code FROM products AS p INNER JOIN bays AS b ON p.bay_id=b.id WHERE b.code IN(#{bay_list}) ORDER BY b.position;")
      @distance = Bay.find_by_sql("SELECT MAX(b.position) - MIN(b.position) AS distance FROM bays AS b WHERE b.code IN(#{bay_list});").first["distance"]
    end

    @by_name = params["search"]["by_name"]
    # By default we start with no bays
    if @by_name != ""
      # Keep only letters, numbers, spaces, and commas
      # Otherwise we risk SQL injection attacks :(
      @by_name.gsub!(/[^A-Za-z0-9\s,]/, "")
      # Turn it into something like: 
      name_list = "'" + @by_name.split(",").join("', '") + "'"
      @bays = Bay.find_by_sql("SELECT b.id, b.code, b.position FROM products AS p INNER JOIN bays AS b ON p.bay_id=b.id WHERE p.name IN(#{name_list}) ORDER BY b.position;")
    end
  end

end