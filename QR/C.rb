require 'pp'

def ppd(*arg)
  if $DEBUG
    pp(*arg)
  end
end

def putsd(*arg)
  if $DEBUG
    puts(*arg)
  end
end

def ri
  readline.to_i
end

def ris
  readline.split.map do |e| e.to_i end
end

def rs
  readline.chomp
end

def rss
  readline.chomp.split
end

def rf
  readline.to_f
end

def rfs
  readline.split.map do |e| e.to_f end
end

def rws(count)
  words = []
  for i in 1 .. count
    words << readline.chomp
  end
  words
end

def solve(r, c, m)
  # 常に縦長を仮定
  board = []
  r.times do
    board << Array.new(c){'.'}
  end

  if c == 1
    # OK
    board[0][0] = 'c'
    for i in 0...m do
      board[r-1-i][0] = '*'
    end
    return board
  end

  if r*c-1 == m
    # OK
    for i in 0...r
      for j in 0...c
        board[i][j] = '*'
      end
    end
    board[0][0] = 'c'
    return board
  end

  if m > r*c - c * 2
    # 縦横複合
    rows = m / c - 1
    if rows <= 0
      return nil
    end

    rest_mines = m - (rows * c)
    rest_rows = r - rows
    rest2 = rest_rows - (rest_mines % rest_rows)
    # return nil if rest2 == 1 && rest_rows <= 3
    return nil if rest_rows <= 2

    board[0][0] = 'c'

    # 縦
    i = r - 1
    j = c - 1
    (rows*c).times do
      board[i][j] = '*'
      j -= 1
      if j < 0
        i -= 1
        j = c - 1
      end
    end

    # 横
    count = rest_mines
    if rest2 == 1
      count -= 1
    end

    i = rest_rows - 1
    j = c - 1
    count.times do
      board[i][j] = '*'
      i -= 1
      if i < 0
        j -= 1
        i = rest_rows - 1
      end
    end

    if rest2 == 1
      # さらに1個ずらす
      board[rest_rows-1][j-1] = '*' # 1個
    end

    # check
    if rest2 == 1 && j-1 == 0
      # OK
    else
      rest_cols = c - (rest_mines.to_f / rest_rows).ceil
      return nil if rest2 == 1 && rest_cols <= 2
      return nil if rest_cols <= 1
    end

    return board
  end

  # 短辺優先に敷き詰め
  mod = m % c

  if c - mod == 1
    return nil if m <= c
    return nil if c == 2

    mine_lines = (m.to_f / c).ceil
    rest = r - mine_lines
    raise if rest < 0

    if rest < 3
      return nil
    else
      # 端から敷き詰めて1個ずらす
      board[0][0] = 'c'
      i = r - 1
      j = c - 1
      (m-1).times do
        board[i][j] = '*'
        j -= 1
        if j < 0
          i -= 1
          j = c - 1
        end
      end
      board[i-1][c-1] = '*' # 1個
      return board
    end
  else
    # 端から敷き詰め
    board[0][0] = 'c'
    i = r - 1
    j = c - 1
    m.times do
      board[i][j] = '*'
      j -= 1
      if j < 0
        i -= 1
        j = c - 1
      end
    end
    return board
  end
end

# main
t_start = Time.now

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  # readline().chomp
  # readline().split

  r, c, m = ris
pp r,c,m
  board1 = solve(r, c, m)
  board2 = solve(c, r, m)

  if board1 || board2
    puts "Case ##{case_index}:"

    if board1
      board1.each do |e|
        puts e.join('')
      end
    elsif board2
      for i in 0...r
        for j in 0...c
          print board2[j][i]
        end
        puts ""
      end
    end
  else
    puts "Case ##{case_index}:\nImpossible"
  end

  # progress
  trigger = 
    if cases >= 10
      case_index % (cases / 10) == 0
    else
      true
    end

  if trigger
    STDERR.puts("case #{case_index} / #{cases}, time: #{Time.now - t_start} s")
  end
end
