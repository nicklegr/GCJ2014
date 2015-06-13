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

def uniq_str(str)
  ret = ''
  last = nil

  str.each_char do |c|
    if last != c
      ret += c
      last = c
    end
  end

  ret
end

# main
t_start = Time.now

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  # readline().chomp
  # readline().split

  n = ri
  arr = rss.map do |e| uniq_str(e) end

  ans = 0

  f = {}
  arr.join('').each_char do |c|
    f[c] = 1
  end
  chars = f.size

  arr.permutation do |p|
    str = p.join('')
    last = nil
    flag = 0
    ok = true
    for i in 0...str.size
      if last != str[i]
        mask = 1 << (str[i].ord - "a".ord)
        if (flag & mask) != 0
          ok = false
          break
        end

        flag |= mask
        last = str[i]
      end
    end

    if ok
      ans += 1
    end
  end

  puts "Case ##{case_index}: #{ans}"

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
