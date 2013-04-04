font 'ShareTechMono-Regular.ttf' #http://www.google.com/fonts#QuickUsePlace:quickUse/Family:

Shoes.app(width: 500, height: 400, title: 'Sample Shoes Clock') do
  # Setup Variables
  @center_x = app.width / 2
  @diameter = 280
  @radius = @diameter / 2
  @offset_y = 10
  @marker_length = 15
  @fps = 10
  
  def clock_hand(time, hand, color = black)
    hand_options = case hand
    when :second then {sw: 1, unit: 30} #unit is half of the clock units for that hand
    when :minute then {sw: 4, unit: 30}
    when :hour then {sw: 8, unit: 6}
    end
    _x = @radius * Math.sin(time * Math::PI / hand_options[:unit])
    _y = @radius * Math.cos(time * Math::PI / hand_options[:unit])
    stroke(color)
    strokewidth(hand_options[:sw])
    line(@center_x, @radius + @offset_y, @center_x + _x, @radius + @offset_y - _y)
  end
  
  def clock_face
    # face
    fill white
    stroke black
    strokewidth 1
    oval left: @center_x - @radius, top: @offset_y, radius: @radius, align: 'center'

    # middle dot
    fill(black)
    nostroke
    oval(left: @center_x - 5, top: @offset_y + @radius - 5, radius: 5, align: 'center')

    # line markers
    stroke black
    strokewidth 1
    line(@center_x, @offset_y, @center_x, @offset_y + @marker_length) # 12:00
    line(@center_x + @radius, @offset_y + @radius, @center_x + @radius - @marker_length, @offset_y + @radius)# 3:00
    line(@center_x, @offset_y + @diameter, @center_x, @offset_y + @diameter - @marker_length)# 6:00
    line(@center_x - @radius, @offset_y + @radius, @center_x - @radius + @marker_length, @offset_y + @radius) # 9:00
  end
  
  def turn_clock_on
    animate(@fps) do
      @time = Time.now
      clear do
        stack do
          background(black)
          banner @time.strftime("%I:%M:%S"), align: 'center', stroke: white, font: 'Share Tech Mono'
        end
        stack do
          clock_face

          # clock hands
          clock_hand(@time.sec, :second, red) #second hand
          clock_hand(@time.min, :minute) #minute hand
          clock_hand(@time.hour, :hour) #hour hand
        end
      end
    end
  end

  # the magic
  button('Turn clock on') do
    turn_clock_on
  end
end