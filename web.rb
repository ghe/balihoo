require 'sinatra'

def swap(seq, x, y)
    tmp = seq[x]
    seq[x] = seq[y]
    seq[y] = tmp
end

def format_puzzle_answer(seq)
    s = " ABCD"
    for x in 0..3
        s += "\n"
        s += "ABCD"[x]
        for y in 0..3
            if seq[x] > seq[y]
                s += '>'
            elsif seq[x] < seq[y]
                s += '<'
            else
                s += '='
            end
        end
    end
    return s
end

def solve_puzzle(pzl)
    given = pzl.lines.map(&:chomp)
    if given.length() > 5
        given = given[2..5]
    else
        return "Invalid Puzzle: #{pzl}"
    end

    seq = [1,2,3,4]
    changed = true
    while changed
        changed = false
        for x in 0..3
            for y in 0..3
                if ((given[y][x+1] == '>' and seq[x] > seq[y]) or
                    (given[y][x+1] == '<' and seq[x] < seq[y]))
                    swap(seq, x, y)
                    changed = true
                end
            end
        end
    end

    return format_puzzle_answer(seq)
end

get '/' do
    @q = params[:q]
    case @q
    when "Ping"
        "OK"
    when "Referrer"
        "Zach Dorsch"
    when "Puzzle"
        solve_puzzle(params[:d])
    when "Position"
        "Sr. Software Developer"
    when "Name"
        "Gerry Ens"
    when "Status"
        "Yes! Greencard, Dutch Citizenship"
    when "Resume"
        "http://www.ensotrading.com/G_Ens_Resume_Balihoo.pdf"
    when "Source"
        "https://github.com/ghe/balihoo"
    when "Degree"
        "MS Computer Science, Northeastern University, Boston, 2005"
    when "Email Address"
        "GerardEns@gmail.com"
    when "Phone"
        "(617) 909-8867"
    when "Years"
        "20+, I'm 35 and have been programming since I was 7 or 8. Didn't get paid for it until I was in my late teens though..."
    else
        "Got: #{@q} ?"
    end
end
