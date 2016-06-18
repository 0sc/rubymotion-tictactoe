class BoardController < UIViewController
  SQUARE_SIZE = 80
  COLORS = [UIColor.greenColor, UIColor.redColor, UIColor.whiteColor]

  def viewDidLoad
    super
    self.new_game
    self.init_views
  end

  def init_views
    view.backgroundColor = UIColor.blackColor

    @board_view = UIView.alloc.initWithFrame([[0,0], [SQUARE_SIZE * 3, SQUARE_SIZE * 3]])
    @board_view.center = view.center

    @square_views = []
    for i in 0..2
      for j in 0..2
        square_view = UIView.alloc.initWithFrame([[j * (SQUARE_SIZE + 2), i * (SQUARE_SIZE + 2)], [SQUARE_SIZE - 4, SQUARE_SIZE - 4]])
        square_view.layer.cornerRadius = 5.0
        square_view.backgroundColor = COLORS[@board.grid[@square_views.length]]

        @square_views[3*i + j] = square_view
        @board_view.addSubview(square_view)
      end
    end

    # create label for display
    @label = UILabel.alloc.initWithFrame([[0,0], [0,0]])
    @label.textColor = UIColor.blackColor
    @label.font = UIFont.systemFontOfSize(30)
    @label.backgroundColor = UIColor.grayColor

    view.addSubview(@label)
    view.addSubview(@board_view)
  end

  def touchesEnded(touched, withEvent:event)
    for i in 0..8
      if event.touchesForView(@square_views[i])
        if !@board.accept_move(i, @current_player)
          show_info("Illegal move!")
        else
          @square_views[i].backgroundColor = COLORS[@board.grid[i]]
          @current_player += 1
          @current_player %= 2
        end
        break
      end
    end

    check_for_winner
  end

  def check_for_winner
    winner = @board.game_over?
    return unless winner

    if winner == -1
      show_info("It's a draw!")
    else
      show_info("Player #{winner + 1} wins!!!")
    end
    sleep 2
    @board.reset
    reset_board
  end

  def new_game
    @board = Board.new
    @current_player = 0
  end

  def show_info(text)
    @label.text = text
    @label.sizeToFit
    @label.center = [160, 50]
  end

  def reset_board
    @square_views.each_with_index{|sqr, i| sqr.backgroundColor = COLORS[@board.grid[i]]}
  end
end
