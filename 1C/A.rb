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

def gcd(m, n)
  if m < n
    return gcd(n, m)
  end

  r = m % n
  if r == 0
    return n
  end

  return gcd(n, r)
end

# main
t_start = Time.now

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  # readline().chomp
  # readline().split

  a, b = rs.split('/').map do |e| e.to_i end

  gcd_ = gcd(a, b)
  a /= gcd_
  b /= gcd_

  tmp = b
  ok = false
  loop do
    if (tmp & 1) == 1
      ok = (tmp == 1)
      break
    end
    tmp >>= 1
  end

  if ok
    ans = 1
    v = 2

    loop do
      if Rational(a, b) >= Rational(1, v)
        break
      end
  
      ans += 1
      v *= 2
    end

    puts "Case ##{case_index}: #{ans}"
  else
    puts "Case ##{case_index}: impossible"
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
