class BoardController < UIViewController
  SQUARE_SIZE = 80
  COLORS = [UIColor.greenColor, UIColor.redColor, UIColor.whiteColor]

  def viewDidLoad
    super
    self.init_views
  end

  def init_views
    view.backgroundColor = UIColor.grayColor

    @board_view = UIView.alloc.initWithFrame([[0,0], [SQUARE_SIZE * 3, SQUARE_SIZE * 3]])
    @board_view.center = view.center

    @square_views = []
    for i in 0..2
      for j in 0..2
        square_view = UIView.alloc.initWithFrame([[j * (SQUARE_SIZE + 2), i * (SQUARE_SIZE + 2)], [SQUARE_SIZE - 4, SQUARE_SIZE - 4]])
        square_view.layer.cornerRadius = 5.0
        square_view.backgroundColor = UIColor.whiteColor

        @square_views[3*i + j] = square_view
        @board_view.addSubview(square_view)
      end
    end

    # create label for display
    @label = UILabel.alloc.initWithFrame([[0,0], [0,0]])
    @label.textColor = UIColor.whiteColor
    @label.font = UIFont.systemFontOfSize(30)
    @label.backgroundColor = nil

    view.addSubview(@label)
    view.addSubview(@board_view)
  end

end
