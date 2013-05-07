$n = 9

$matrix = Array.new($n)
for i in 0..$n-1
	$matrix[i] = Array.new($n)
end

$visit = Array.new($n)
$prev = Array.new($n)
$dist = Array.new($n)

$visited = 0

for i in 0..$n-1
	for j in 0..$n-1
		if i == j
			$matrix[i][j] = 0
		else
			$matrix[i][j] = 9999
		end
	end

	$visit[i] = false
	$dist[i] = 9999
end
	
$dist[0] = 0


#abcdefghi
#012345678

def pushNode(i,j,dist)
	$matrix[i][j] = dist
	$matrix[j][i] = dist
end

pushNode(0,2, 31)
pushNode(0,3, 36)

pushNode(1,4, 23)

pushNode(2,5, 50)
pushNode(2,3, 29)

pushNode(3,1, 45)
pushNode(3,2, 29)
pushNode(3,5, 11)
pushNode(3,4, 28)
pushNode(3,6, 72)

pushNode(4,8, 15)
pushNode(4,6, 17)

pushNode(5,6, 63)

pushNode(6,7, 56)

def dijikstra
	i = 0
	next_i = 0

	$visit[0] = true

	for  k in 0..$n-1
		puts (i+65).chr

		min = 9999
		for j in 0..$n-1
#			if i==j or $matrix[i][j] == 9999 or $visit[j] == true
#			else
				if $dist[j] > $dist[i] + $matrix[i][j]
					$dist[j] = $dist[i] + $matrix[i][j]

					if $dist[j] < min
						min = $dist[j]
						next_i = j
					end
				else
					if $dist[j] < min
						min = $dist[j]
						next_i = j
					end
				end
#			end
		end

		if min == 9999
			for j in 0..$n-1
				if $visit[j] == false
					next_i = j
					break
				end
			end
		end

		if $visit[next_i] == false
			$visit[next_i] = true
			$visited += 1
		end

		i = next_i
	end	

	p $visit
end

dijikstra()

p $dist