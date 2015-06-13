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

def msb(value)
  if value == 0
    return -1
  end

  n = 0
  mask = 1
  v = value
  loop do
    v &= ~mask
    if v == 0
      return n
    end
    mask <<= 1
    n += 1
  end
end

def get_n(value, n)
  (value >> n) & 1
end

def down(value, n)
  value & ~(1 << n)
end

# 100
def down_above(value, n)
  value & ((1 << (n+1)) - 1)
end

# @todo Kの最上位より上の桁が0にする場合
def solve2(a, b, k)
  min = msb(k)
  max = [msb(a), msb(b)].max

  total = 1
  for i in min+1..max
    pat = 1
    pat += 1 if (1 << i) < $org_a
    pat += 1 if (1 << i) < $org_b
    total *= pat
  end

  total * solve(down_above(a, min), down_above(b, min), k, min)
end

def solve(a, b, k, pos)
  if pos == -1
    return 0
  end

  pat = 1
  pat += 1 if (1 << pos) < $org_a
  pat += 1 if (1 << pos) < $org_b

  next_a = a # down(a, pos)
  next_b = b # down(b, pos)
  next_k = k # down(k, pos)

  if get_n(k, pos) == 1
    # 00, 01, 10, 11
    a_all = [(1 << pos), $org_a].min
    b_all = [(1 << pos), $org_b].min

    ok = ((1 << pos) < $org_a) && ((1 << pos) < $org_b)

    aa = pat * a_all * b_all
    bb =
      if ok
        solve(next_a, next_b, next_k, pos-1)
      else
        0
      end

    return aa + bb
  else
    # 00, 01, 10
    return pat * solve(next_a, next_b, next_k, pos-1)
  end
end

# main
t_start = Time.now

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  # readline().chomp
  # readline().split

  a, b, k = ris
  $org_a = a
  $org_b = b

  puts "Case ##{case_index}: #{solve2(a, b, k)}"
  # puts "Case ##{case_index}: #{solve(a, b, k, msb(k))}"

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
