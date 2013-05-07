
class Point
	attr_accessor :x, :y, :f

	def initialize(x,y,f=0)
		@x = x
		@y = y
		@f = f
	end
end

def init(n)
	$n = n

	$map = Array.new($n)
	for i in 0..$n-1
		$map[i] = Array.new($n)
	end

	$f = Array.new($n)
	for i in 0..$n-1
		$f[i] = Array.new($n)
	end

	$open = Array.new
	$close = Array.new

	$path = Array.new
end

def input(file)
	file = File.new(file)

	for i in 0..$n-1
		read = file.read($n+2)
		for j in 0..$n-1
			$map[i][j] = read[j]
		end
	end

	file.close	
end

def push(pt)
	flag = true

	$open.each do |p|
		if p.x == pt.x and p.y == pt.y
			flag = false
		end
	end
	$close.each do |p|
		if p.x == pt.x and p.y == pt.y
			flag = false
		end
	end

	$open.push pt if flag == true

	flag
end
def a_star
	$open.push Point.new(0,0)

	$f[0][0] = 0

	while $open.empty? == false
		u = Point.new(-1,-1,9999)	

		$open.each do |p|
			if $f[p.x][p.y] < u.f	
				u = p
			end
		end

#		puts u.x.to_s + ", " + u.y.to_s
		$open.each do |p|
			if p.x == u.x and p.y == u.y
				if p.x == 1 and p.y == 1
					$path.pop
				end
				if p.f < u.f
					p p.f.to_s + ", " + u.f.to_s
				end
			end
		end
		$open.delete_if {
			|v| v.x == u.x and v.y == u.y
		}
		$close.push u

		$path.push u

		if u.x == $n-1 and u.y == $n-1
			break
		end

		# 오픈 목록 확장
		pt = 0
		if u.x != $n-1 and u.y != $n-1 and $map[u.x+1][u.y+1] == "0"
			if push(Point.new(u.x+1,u.y+1, u.f+1.4)) == true
				$f[u.x+1][u.y+1] = u.f+1.4
			end
		end
		if u.x != $n-1 and $map[u.x+1][u.y] == "0"
			if push(Point.new(u.x+1,u.y, u.f+1.0)) == true
				$f[u.x+1][u.y] = u.f+1.0
			end
		end
		if u.y != $n-1 and $map[u.x][u.y+1] == "0"
			if push(Point.new(u.x,u.y+1, u.f+1.0)) == true
				$f[u.x][u.y+1] = u.f+1.0
			end
		end
		if u.x != 0 and u.y != $n-1 and $map[u.x-1][u.y+1] == "0" 
			if push(Point.new(u.x-1,u.y+1, u.f+1.4)) == true
				$f[u.x-1][u.y+1] = u.f+1.4
			end
		end
		if u.x != $n-1 and u.y != 0 and $map[u.x+1][u.y-1] == "0"
			if push(Point.new(u.x+1,u.y-1, u.f+1.4)) == true
				$f[u.x+1][u.y-1] = u.f+1.4
			end
		end
		if u.x != 0 and $map[u.x-1][u.y] == "0"
			if push(Point.new(u.x-1,u.y, u.f+1.0)) == true
				$f[u.x-1][u.y] = u.f+1.0
			end
		end
		if u.y != 0 and $map[u.x][u.y-1] == "0"
			if push(Point.new(u.x,u.y-1, u.f+1.0)) == true
				$f[u.x][u.y-1] = u.f+1.0
			end
		end
		if u.x != 0 and u.y != 0 and $map[u.x-1][u.y-1] == "0"
			if push(Point.new(u.x-1,u.y-1, u.f+1.4)) == true
				$f[u.x-1][u.y-1] = u.f+1.4
			end
		end
	end
end

init			7
input		"map1.txt"
a_star

for i in 0..$path.size-1
	p $path[i].x.to_s + ", " + $path[i].y.to_s
end

for i in 0..$n-1
	msg = ""
	for j in 0..$n-1
		msg += $f[i][j].to_i.to_s + ", "
	end

	p msg
end

